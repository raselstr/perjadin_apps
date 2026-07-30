from types import SimpleNamespace

from django.template.loader import render_to_string
from django.test import SimpleTestCase

from .access import is_spj_admin_user, is_spj_pengguna_user


class SPJUploadTemplateTests(SimpleTestCase):
    def test_photo_handler_skips_non_image_files(self):
        template = render_to_string("includes/scripts.html", request=None)

        self.assertIn("shouldHandleInput(input)", template)
        self.assertIn("file.type && file.type.startsWith('image/')", template)
        self.assertNotIn("accept.includes('image')", template)


class SPJAccessTests(SimpleTestCase):
    def test_superuser_is_admin_even_without_role_scope(self):
        user = SimpleNamespace(is_superuser=True, is_authenticated=True)

        self.assertTrue(is_spj_admin_user(user))
        self.assertFalse(is_spj_pengguna_user(user))
