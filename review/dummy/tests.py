from django.core.urlresolvers import reverse
from django.test import TestCase


class DummyTestCase(TestCase):

    @property
    def content(self):
        return self.client.get(reverse('dummy')).content

    def test_index_hello(self):
        self.assertIn(b'Hello: self-deploying app and static', self.content)

    def test_counter(self):
        self.assertIn(b'Visits: 1.', self.content)
        self.assertIn(b'Visits: 2.', self.content)
