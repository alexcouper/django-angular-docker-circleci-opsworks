from django.core.urlresolvers import reverse
from django.test import TestCase


class DummyTestCase(TestCase):

    def test_index_hello(self):
        content = self.client.get(reverse('dummy')).content
        self.assertIn(b'Hello: self-deploying app and static', content)
