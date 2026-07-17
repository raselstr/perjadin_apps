from django.template.loader import render_to_string
from django.test import SimpleTestCase


class SPJUploadTemplateTests(SimpleTestCase):
    def test_photo_handler_skips_non_image_files(self):
        template = render_to_string("includes/scripts.html", request=None)

        self.assertIn("shouldHandleInput(input)", template)
        self.assertIn("file.type && file.type.startsWith('image/')", template)
        self.assertNotIn("accept.includes('image')", template)
