# Image Compression Utility - Usage Guide

## Overview
The `image_compression.py` module provides utilities for compressing and validating images in Django applications. It supports JPEG, PNG, and WEBP formats with configurable quality and size limits.

## Main Functions

### 1. `compress_image_file()` - Process Django Uploads
The primary function for processing Django file uploads.

```python
from core.utils.image_compression import compress_image_file, ImageCompressionError
from django.core.files.uploadedfile import InMemoryUploadedFile

# In your model save() method:
def save(self, *args, **kwargs):
    if self.photo:
        try:
            self.photo = compress_image_file(self.photo)
        except ImageCompressionError as e:
            logger.error(f"Image compression failed: {e}")
            raise
    super().save(*args, **kwargs)
```

**Parameters:**
- `uploaded_file`: Django InMemoryUploadedFile or TemporaryUploadedFile
- `max_width`: Maximum width (default: 1920)
- `max_height`: Maximum height (default: 1080)
- `quality`: JPEG/WEBP quality 0-100 (default: 85)

**Returns:**
- New `InMemoryUploadedFile` with compressed image data

**Raises:**
- `ImageCompressionError`: If file is invalid or compression fails
- `TypeError`: If uploaded_file is not a Django uploaded file

---

### 2. `compress_image()` - Low-Level Compression
Direct image compression from raw bytes.

```python
from core.utils.image_compression import compress_image
from io import BytesIO

# Compress image bytes
image_bytes = open('photo.jpg', 'rb').read()
compressed_io = compress_image(image_bytes, format_hint='JPEG', quality=85)

# compressed_io is a BytesIO object ready to save
with open('compressed.jpg', 'wb') as f:
    f.write(compressed_io.getvalue())
```

**Parameters:**
- `image_data`: Raw image bytes
- `format_hint`: Image format (JPEG, PNG, WEBP) - auto-detected if None
- `max_width`: Maximum width (default: 1920)
- `max_height`: Maximum height (default: 1080)
- `quality`: Compression quality (default: 85)

**Returns:**
- `BytesIO` object with compressed image

---

### 3. `validate_image_file()` - Verify Valid Images
Check if a file is a valid image.

```python
from core.utils.image_compression import validate_image_file

if validate_image_file('/path/to/image.jpg'):
    print("Valid image!")
else:
    print("Invalid or corrupted image")
```

---

### 4. `get_image_dimensions()` - Get Image Size
Retrieve image dimensions.

```python
from core.utils.image_compression import get_image_dimensions

dimensions = get_image_dimensions('/path/to/image.jpg')
if dimensions:
    width, height = dimensions
    print(f"Image size: {width}x{height}")
```

---

## Integration with Django Models

### Example 1: Simple Model with Photo
```python
from django.db import models
from core.utils.image_compression import compress_image_file, ImageCompressionError
import logging

logger = logging.getLogger(__name__)

class PhotoModel(models.Model):
    photo = models.ImageField(upload_to='photos/')
    
    def save(self, *args, **kwargs):
        if self.photo:
            try:
                self.photo = compress_image_file(self.photo)
            except ImageCompressionError as e:
                logger.error(f"Failed to compress photo: {e}")
                raise  # Re-raise to prevent model from saving
        super().save(*args, **kwargs)
```

### Example 2: Multiple Image Fields
```python
from django.db import models
from core.utils.image_compression import compress_image_file, ImageCompressionError
import logging

logger = logging.getLogger(__name__)

class UserProfile(models.Model):
    profile_picture = models.ImageField(upload_to='profiles/')
    banner_image = models.ImageField(upload_to='banners/', blank=True, null=True)
    
    def save(self, *args, **kwargs):
        # Compress profile picture (stricter quality)
        if self.profile_picture:
            try:
                self.profile_picture = compress_image_file(self.profile_picture, quality=90)
            except ImageCompressionError as e:
                logger.error(f"Profile picture compression failed: {e}")
                raise
        
        # Compress banner image (can use lower quality)
        if self.banner_image:
            try:
                self.banner_image = compress_image_file(self.banner_image, quality=80)
            except ImageCompressionError as e:
                logger.warning(f"Banner compression failed: {e}")
                # Optionally allow saving without compression
        
        super().save(*args, **kwargs)
```

### Example 3: With Custom Dimensions
```python
from django.db import models
from core.utils.image_compression import compress_image_file, ImageCompressionError

class ProductImage(models.Model):
    image = models.ImageField(upload_to='products/')
    
    def save(self, *args, **kwargs):
        if self.image:
            try:
                # Custom dimensions for this model
                self.image = compress_image_file(
                    self.image,
                    max_width=1280,
                    max_height=960,
                    quality=85
                )
            except ImageCompressionError as e:
                raise
        super().save(*args, **kwargs)
```

---

## Configuration Constants

Edit these constants in `image_compression.py` to customize behavior:

```python
MAX_WIDTH = 1920              # Maximum image width
MAX_HEIGHT = 1080             # Maximum image height
JPEG_QUALITY = 85             # JPEG compression quality (0-100)
SUPPORTED_FORMATS = {'JPEG', 'PNG', 'WEBP'}
ACCEPTABLE_MIME_TYPES = {
    'image/jpeg',
    'image/png',
    'image/webp',
}
```

---

## Features

✓ **Automatic Resizing**: Resizes images while preserving aspect ratio
✓ **Format Support**: JPEG, PNG, WEBP with automatic format detection
✓ **EXIF Preservation**: Attempts to preserve EXIF metadata from original images
✓ **Error Handling**: Gracefully handles invalid/corrupt images with logging
✓ **Validation**: Validates images before and after compression
✓ **Logging**: Comprehensive logging for debugging and monitoring
✓ **Django Integration**: Works seamlessly with Django's file upload system

---

## Error Handling

The module provides `ImageCompressionError` exception for all compression-related errors:

```python
from core.utils.image_compression import compress_image_file, ImageCompressionError
import logging

logger = logging.getLogger(__name__)

try:
    compressed_file = compress_image_file(uploaded_file)
except ImageCompressionError as e:
    logger.error(f"Image compression failed: {e}")
    # Handle error - return validation error to user, etc.
except TypeError as e:
    logger.error(f"Invalid file type: {e}")
    # Handle invalid file type
```

---

## Performance Notes

- **Memory Usage**: Images are processed in memory. Very large original files may use significant RAM
- **Processing Time**: Compression is fast (~100-500ms for typical web images)
- **Format Conversion**: PNG to JPEG conversion is lossless (white background added for transparency)
- **EXIF Handling**: EXIF preservation is best-effort; not guaranteed for all formats

---

## Logging

The module logs compression statistics at INFO level and errors at ERROR level:

```
INFO: Image compressed successfully: 4000x3000 -> 1920x1440, 5242880 bytes -> 1048576 bytes (80.0% reduction)
```

Configure logging in Django settings:

```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': 'image_compression.log',
        },
    },
    'loggers': {
        'core.utils.image_compression': {
            'handlers': ['file'],
            'level': 'INFO',
        },
    },
}
```

---

## Dependencies

- Python 3.8+
- Django 3.2+
- Pillow 8.0+ (already in requirements.txt)

---

## Testing

Basic test example:

```python
from core.utils.image_compression import compress_image_file, ImageCompressionError
from django.core.files.uploadedfile import SimpleUploadedFile
from PIL import Image
from io import BytesIO

# Create test image
img = Image.new('RGB', (4000, 3000), color='red')
img_bytes = BytesIO()
img.save(img_bytes, format='JPEG')
img_bytes.seek(0)

# Create Django uploaded file
uploaded_file = SimpleUploadedFile(
    "test.jpg",
    img_bytes.getvalue(),
    content_type="image/jpeg"
)

# Compress
try:
    compressed = compress_image_file(uploaded_file)
    print(f"Original: {uploaded_file.size} bytes")
    print(f"Compressed: {compressed.size} bytes")
except ImageCompressionError as e:
    print(f"Error: {e}")
```
