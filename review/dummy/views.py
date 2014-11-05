from django.shortcuts import render


def index(request):
    counter = request.session.get('counter', 1)
    request.session['counter'] = counter + 1
    return render(request, 'index.html', {'counter': counter})
