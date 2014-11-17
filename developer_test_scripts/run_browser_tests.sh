#!/bin/bash
set -e
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
# Wait for the postgres port to be available
DOCKER_ADDR=`echo $APP_SERVICE_URL | sed 's#.*//\([0-9.]*\).*#\1#'`
until nc -z $DOCKER_ADDR 5432
do
    echo "waiting for postgres container..."
    sleep 0.5
done
PG_CONTAINER=`docker ps | grep _postgres_ | awk '{ print $1; }'`
$FIG run app python3 manage.py migrate --noinput
$FIG up -d --no-deps app
set +e
npm run protractor
$FIG stop app
$FIG stop postgres
echo "Removing postgres container"
docker rm $PG_CONTAINER
