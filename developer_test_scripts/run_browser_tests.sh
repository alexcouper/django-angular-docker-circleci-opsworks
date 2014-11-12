#!/bin/bash
if [[ -z "$APP_SERVICE_URL" ]];
then
    echo "You must set the APP_SERVICE_URL environment variable to point to the normal dev server http://addr:port combination"
    exit 1
fi
FIG='fig --file fig-developer-tests.yml'
echo "Ensuring containers are stopped"
$FIG stop app
$FIG stop postgres
$FIG up -d postgres
until docker ps | grep _postgres_
do
    echo "Waiting for postgres container to come up..."
    sleep 0.25
done
PG_CONTAINER=`docker ps | grep _postgres_ | awk '{ print $1; }'`
$FIG run app python3 manage.py migrate --noinput
$FIG up -d --no-deps app
npm run protractor
$FIG stop app
$FIG stop postgres
echo "Removing postgres container"
docker rm $PG_CONTAINER
