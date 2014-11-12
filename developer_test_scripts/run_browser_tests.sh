#!/bin/bash
if [[ -z "$APP_SERVICE_URL" ]];
then
    echo "You must set the APP_SERVICE_URL environment variable to point to the normal dev server http://addr:port combination"
    exit 1
fi
FIG='fig --file fig-developer-tests.yml'
$FIG up -d postgres
$FIG run app python3 manage.py syncdb --noinput
$FIG run app python3 manage.py migrate --noinput
$FIG up -d --no-deps app
npm run protractor
$FIG stop app
$FIG stop postgres
