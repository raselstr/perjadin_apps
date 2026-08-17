from types import SimpleNamespace

from django.template.loader import render_to_string
from django.test import SimpleTestCase

from .access import (
    filter_spj_queryset_for_user,
    is_spj_approver_user,
    is_spj_admin_user,
    is_spj_pengguna_user,
)


class RecordingQuerySet:
    def __init__(self):
        self.filter_kwargs = None
        self.none_called = False

    def filter(self, **kwargs):
        self.filter_kwargs = kwargs
        return self

    def none(self):
        self.none_called = True
        return self


class SPJUploadTemplateTests(SimpleTestCase):
    def test_photo_handler_skips_non_image_files(self):
        template = render_to_string("includes/scripts.html", request=None)

        self.assertIn("shouldHandleInput(input)", template)
        self.assertIn("file.type && file.type.startsWith('image/')", template)
        self.assertNotIn("accept.includes('image')", template)


class SPJAccessTests(SimpleTestCase):
    @staticmethod
    def _role_user(role_name, is_superuser=False):
        return SimpleNamespace(
            is_superuser=is_superuser,
            is_authenticated=True,
            userprofile=SimpleNamespace(
                role=SimpleNamespace(nama=role_name),
            ),
        )

    def test_superuser_is_admin_even_without_role_scope(self):
        user = SimpleNamespace(is_superuser=True, is_authenticated=True)

        self.assertTrue(is_spj_admin_user(user))
        self.assertFalse(is_spj_pengguna_user(user))
        self.assertTrue(is_spj_approver_user(user))

    def test_only_bendahara_role_can_approve_spj(self):
        self.assertTrue(is_spj_approver_user(self._role_user("Bendahara")))
        self.assertTrue(is_spj_approver_user(self._role_user(" bendahara ")))
        self.assertFalse(is_spj_approver_user(self._role_user("Verifikator")))
        self.assertFalse(is_spj_approver_user(self._role_user("Pengguna")))

    def test_non_superuser_filters_by_active_opd(self):
        request = SimpleNamespace(
            user=SimpleNamespace(is_superuser=False, is_authenticated=True),
            session={"session_opd_id": 7},
        )
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(
            queryset,
            request,
            "pelaksana__nama__nip",
        )

        self.assertIs(result, queryset)
        self.assertEqual(queryset.filter_kwargs, {"pelaksana__nama__opd_id": 7})

        pelaksana_queryset = RecordingQuerySet()
        filter_spj_queryset_for_user(pelaksana_queryset, request, "nama__nip")
        self.assertEqual(pelaksana_queryset.filter_kwargs, {"nama__opd_id": 7})

    def test_non_superuser_without_active_opd_gets_empty_queryset(self):
        request = SimpleNamespace(
            user=SimpleNamespace(is_superuser=False, is_authenticated=True),
            session={},
        )
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(queryset, request, "nama__nip")

        self.assertIs(result, queryset)
        self.assertTrue(queryset.none_called)

    def test_pengguna_filters_by_logged_in_username_nip(self):
        request = SimpleNamespace(
            user=self._role_user("Pengguna"),
            session={"session_opd_id": 7},
        )
        request.user.username = "198001012005011001"
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(
            queryset,
            request,
            "pelaksana__nama__nip",
        )

        self.assertIs(result, queryset)
        self.assertEqual(
            queryset.filter_kwargs,
            {"pelaksana__nama__nip": "198001012005011001"},
        )
