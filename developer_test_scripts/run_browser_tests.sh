#!/bin/bash
set -e
if [[ -z "$APP_SERVICE_URL" ]];
then
    echo "You must set the APP_SERVICE_URL environment variable to point to the normal dev server http://addr:port combination"
    exit 1
fi
COMPOSE='docker-compose --file docker-compose-developer-tests.yml'
echo "Ensuring containers are stopped"
$COMPOSE stop app
$COMPOSE stop postgres
$COMPOSE up -d postgres
# Wait for the postgres port to be available
DOCKER_ADDR=`echo $APP_SERVICE_URL | sed 's#.*//\([0-9.]*\).*#\1#'`
until nc -z $DOCKER_ADDR 5432
do
    echo "waiting for postgres container..."
    sleep 0.5
done
PG_CONTAINER=`docker ps | grep _postgres_ | awk '{ print $1; }'`
$COMPOSE run app python3 manage.py migrate --noinput
$COMPOSE up -d --no-deps app
set +e
npm run protractor
$COMPOSE stop app
$COMPOSE stop postgres
echo "Removing postgres container"
docker rm $PG_CONTAINER
