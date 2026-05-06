from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse
from django.utils import timezone


class SessionSecurityViewTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username="operator",
            password="rahasia123",
        )

    def test_session_heartbeat_refreshes_last_activity(self):
        self.client.force_login(self.user)

        session = self.client.session
        previous_timestamp = int(timezone.now().timestamp()) - 10
        session["last_activity"] = previous_timestamp
        session.save()

        response = self.client.get(reverse("session_heartbeat"))

        self.assertEqual(response.status_code, 204)
        self.assertGreater(
            self.client.session["last_activity"],
            previous_timestamp,
        )

    def test_timeout_logout_redirects_to_expired_login(self):
        self.client.force_login(self.user)

        response = self.client.get(reverse("timeout_logout"))

        self.assertRedirects(response, f"{reverse('masuk')}?expired=1")
        self.assertNotIn("_auth_user_id", self.client.session)
