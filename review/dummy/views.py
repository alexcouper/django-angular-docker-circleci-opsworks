import logging

from django.shortcuts import render

LOGGER = logging.getLogger(__name__)


def index(request):
    LOGGER.info(u'index page request')
    counter = request.session.get('counter', 1)
    request.session['counter'] = counter + 1
    return render(request, 'index.html', {'counter': counter})
