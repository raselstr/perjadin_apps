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

    def test_login_view_has_never_cache_headers(self):
        response = self.client.get(reverse("masuk"))
        self.assertEqual(response.status_code, 200)
        cache_control = response.headers.get("Cache-Control", "")
        self.assertIn("no-cache", cache_control)
        self.assertIn("no-store", cache_control)

    def test_csrf_failure_on_login_redirects_gracefully(self):
        from profiles.views import csrf_failure_view
        from django.test import RequestFactory
        factory = RequestFactory()
        request = factory.post("/profiles/masuk/?expired=1", {"username": "admin"})
        # Add session and messages support
        from django.contrib.sessions.middleware import SessionMiddleware
        from django.contrib.messages.middleware import MessageMiddleware
        middleware = SessionMiddleware(lambda r: None)
        middleware.process_request(request)
        request.session.save()
        msg_middleware = MessageMiddleware(lambda r: None)
        msg_middleware.process_request(request)

        response = csrf_failure_view(request, reason="CSRF token from POST incorrect.")
        self.assertEqual(response.status_code, 302)
        self.assertEqual(response["Location"], f"{reverse('masuk')}?expired=1")
