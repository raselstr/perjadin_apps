"""
Image compression utility module for Django file uploads.

This module provides functions to compress images while preserving quality
and EXIF data. It handles multiple image formats (JPEG, PNG, WEBP) and
supports both in-memory and temporary file uploads.

Compression specifications:
- Maximum dimensions: 1920x1080
- JPEG quality: 85%
- Supported formats: JPEG, PNG, WEBP
- EXIF data preservation: Attempted where supported
"""

import io
import logging
import os
from io import BytesIO
from pathlib import Path

from django.core.files.uploadedfile import InMemoryUploadedFile, TemporaryUploadedFile
from PIL import Image
from PIL.ExifTags import TAGS

logger = logging.getLogger(__name__)

# Compression constants
MAX_WIDTH = 1920
MAX_HEIGHT = 1080
JPEG_QUALITY = 85
SUPPORTED_FORMATS = {'JPEG', 'PNG', 'WEBP'}
ACCEPTABLE_MIME_TYPES = {
    'image/jpeg',
    'image/png',
    'image/webp',
}


class ImageCompressionError(Exception):
    """Raised when image compression fails."""
    pass


def get_exif_data(image: Image.Image) -> dict:
    """
    Extract EXIF data from an image.

    Args:
        image: PIL Image object

    Returns:
        Dictionary mapping EXIF tag IDs to their values
    """
    exif_data = {}
    try:
        exif = image._getexif()
        if exif is not None:
            for tag_id, value in exif.items():
                tag_name = TAGS.get(tag_id, tag_id)
                exif_data[tag_id] = value
    except (AttributeError, KeyError, IndexError) as e:
        logger.debug(f"Could not extract EXIF data: {e}")
    return exif_data


def preserve_exif_data(original_image: Image.Image, compressed_image: Image.Image) -> Image.Image:
    """
    Attempt to preserve EXIF data from original image to compressed image.

    Args:
        original_image: Original PIL Image object
        compressed_image: Compressed PIL Image object

    Returns:
        Compressed image with EXIF data preserved (if possible)
    """
    try:
        exif_data = get_exif_data(original_image)
        if exif_data:
            # For JPEG and other formats that support EXIF
            try:
                from PIL.Image import Exif
                exif = Exif()
                for tag_id, value in exif_data.items():
                    try:
                        exif[tag_id] = value
                    except (KeyError, TypeError):
                        # Some EXIF tags cannot be set directly
                        pass
                return compressed_image
            except ImportError:
                logger.debug("PIL Exif class not available, EXIF data will not be preserved")
    except Exception as e:
        logger.warning(f"Failed to preserve EXIF data: {e}")

    return compressed_image


def resize_image(image: Image.Image, max_width: int = MAX_WIDTH, max_height: int = MAX_HEIGHT) -> Image.Image:
    """
    Resize image to fit within max dimensions while maintaining aspect ratio.

    Args:
        image: PIL Image object
        max_width: Maximum width in pixels
        max_height: Maximum height in pixels

    Returns:
        Resized PIL Image object
    """
    if image.width <= max_width and image.height <= max_height:
        return image

    image.thumbnail((max_width, max_height), Image.Resampling.LANCZOS)
    return image


def compress_image(
    image_data: bytes,
    format_hint: str = None,
    max_width: int = MAX_WIDTH,
    max_height: int = MAX_HEIGHT,
    quality: int = JPEG_QUALITY,
) -> BytesIO:
    """
    Compress an image and return as BytesIO object.

    Args:
        image_data: Raw image bytes
        format_hint: Expected image format (JPEG, PNG, WEBP). Auto-detected if None.
        max_width: Maximum width in pixels (default: 1920)
        max_height: Maximum height in pixels (default: 1080)
        quality: JPEG/WEBP compression quality 0-100 (default: 85)

    Returns:
        BytesIO object containing compressed image

    Raises:
        ImageCompressionError: If image is invalid or compression fails
    """
    if not image_data:
        raise ImageCompressionError("Image data is empty")

    try:
        # Open image from bytes
        original_image = Image.open(io.BytesIO(image_data))
        original_image.load()  # Force load to detect corrupted images early
    except Exception as e:
        logger.error(f"Failed to open image: {e}")
        raise ImageCompressionError(f"Invalid or corrupted image: {e}")

    try:
        # Determine format
        image_format = original_image.format or format_hint
        if not image_format:
            raise ImageCompressionError("Unable to determine image format")

        image_format = image_format.upper()
        if image_format == 'JPG':
            image_format = 'JPEG'

        if image_format not in SUPPORTED_FORMATS:
            raise ImageCompressionError(
                f"Unsupported image format: {image_format}. Supported: {SUPPORTED_FORMATS}"
            )

        # Convert RGBA to RGB if saving as JPEG
        if image_format == 'JPEG' and original_image.mode in ('RGBA', 'LA', 'P'):
            rgb_image = Image.new('RGB', original_image.size, (255, 255, 255))
            if original_image.mode == 'P':
                original_image = original_image.convert('RGBA')
            rgb_image.paste(original_image, mask=original_image.split()[-1] if original_image.mode in ('RGBA', 'LA') else None)
            original_image = rgb_image

        # Resize while maintaining aspect ratio
        compressed_image = resize_image(original_image, max_width, max_height)

        # Preserve EXIF if available
        compressed_image = preserve_exif_data(original_image, compressed_image)

        # Compress and save to BytesIO
        output = BytesIO()
        save_kwargs = {'format': image_format, 'optimize': True}

        if image_format == 'JPEG':
            save_kwargs['quality'] = quality
        elif image_format == 'WEBP':
            save_kwargs['quality'] = quality

        compressed_image.save(output, **save_kwargs)
        output.seek(0)

        # Log compression stats
        original_size = len(image_data)
        compressed_size = len(output.getvalue())
        compression_ratio = (1 - compressed_size / original_size) * 100 if original_size > 0 else 0

        logger.info(
            f"Image compressed successfully: {original_image.size[0]}x{original_image.size[1]} -> "
            f"{compressed_image.size[0]}x{compressed_image.size[1]}, "
            f"{original_size} bytes -> {compressed_size} bytes ({compression_ratio:.1f}% reduction)"
        )

        return output

    except ImageCompressionError:
        raise
    except Exception as e:
        logger.error(f"Image compression failed: {e}", exc_info=True)
        raise ImageCompressionError(f"Compression failed: {e}")


def compress_image_file(
    uploaded_file,
    max_width: int = MAX_WIDTH,
    max_height: int = MAX_HEIGHT,
    quality: int = JPEG_QUALITY,
) -> InMemoryUploadedFile:
    """
    Process a Django uploaded file and return a compressed version.

    This function accepts either InMemoryUploadedFile or TemporaryUploadedFile,
    compresses the image, and returns a new InMemoryUploadedFile that can
    replace the original upload.

    Args:
        uploaded_file: Django InMemoryUploadedFile or TemporaryUploadedFile
        max_width: Maximum width in pixels (default: 1920)
        max_height: Maximum height in pixels (default: 1080)
        quality: JPEG/WEBP compression quality 0-100 (default: 85)

    Returns:
        InMemoryUploadedFile with compressed image data

    Raises:
        ImageCompressionError: If file is invalid or compression fails
        TypeError: If uploaded_file is not a Django uploaded file
    """
    if not isinstance(uploaded_file, (InMemoryUploadedFile, TemporaryUploadedFile)):
        raise TypeError(
            f"Expected InMemoryUploadedFile or TemporaryUploadedFile, "
            f"got {type(uploaded_file).__name__}"
        )

    # Validate MIME type
    if uploaded_file.content_type not in ACCEPTABLE_MIME_TYPES:
        raise ImageCompressionError(
            f"Invalid image format: {uploaded_file.content_type}. "
            f"Accepted: {ACCEPTABLE_MIME_TYPES}"
        )

    try:
        # Read the uploaded file
        uploaded_file.seek(0)
        image_data = uploaded_file.read()

        if not image_data:
            raise ImageCompressionError("Uploaded file is empty")

        # Detect format from file extension and MIME type
        original_name = uploaded_file.name.lower()
        if original_name.endswith('.jpg'):
            format_hint = 'JPEG'
        elif original_name.endswith('.jpeg'):
            format_hint = 'JPEG'
        elif original_name.endswith('.png'):
            format_hint = 'PNG'
        elif original_name.endswith('.webp'):
            format_hint = 'WEBP'
        else:
            format_hint = None

        # Compress the image
        compressed_io = compress_image(
            image_data,
            format_hint=format_hint,
            max_width=max_width,
            max_height=max_height,
            quality=quality,
        )

        # Determine output format and file extension
        original_image = Image.open(io.BytesIO(image_data))
        output_format = (original_image.format or format_hint or 'JPEG').upper()
        if output_format == 'JPG':
            output_format = 'JPEG'

        # Create new filename with appropriate extension
        name_without_ext = Path(uploaded_file.name).stem
        ext_map = {'JPEG': '.jpg', 'PNG': '.png', 'WEBP': '.webp'}
        new_extension = ext_map.get(output_format, '.jpg')
        new_filename = f"{name_without_ext}{new_extension}"

        # Create InMemoryUploadedFile
        compressed_file = InMemoryUploadedFile(
            file=compressed_io,
            field_name=uploaded_file.field_name,
            name=new_filename,
            content_type=f"image/{output_format.lower()}",
            size=len(compressed_io.getvalue()),
            charset=None,
        )

        logger.info(
            f"Successfully processed uploaded file '{uploaded_file.name}' -> '{new_filename}' "
            f"({len(image_data)} -> {len(compressed_io.getvalue())} bytes)"
        )

        return compressed_file

    except ImageCompressionError:
        raise
    except TypeError:
        raise
    except Exception as e:
        logger.error(f"Failed to process uploaded file '{uploaded_file.name}': {e}", exc_info=True)
        raise ImageCompressionError(f"Failed to process uploaded file: {e}")


def validate_image_file(file_path: str) -> bool:
    """
    Validate that a file is a valid image.

    Args:
        file_path: Path to the image file

    Returns:
        True if file is a valid image, False otherwise
    """
    try:
        with Image.open(file_path) as img:
            img.verify()
        return True
    except Exception as e:
        logger.warning(f"Invalid image file '{file_path}': {e}")
        return False


def get_image_dimensions(file_path: str) -> tuple:
    """
    Get the dimensions of an image file.

    Args:
        file_path: Path to the image file

    Returns:
        Tuple of (width, height) or None if file is invalid
    """
    try:
        with Image.open(file_path) as img:
            return img.size
    except Exception as e:
        logger.warning(f"Could not get dimensions for '{file_path}': {e}")
        return None
