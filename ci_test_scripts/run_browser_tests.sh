#!/bin/bash
set -e
# Keep the Postgres version in step with that at AWS RDS (currently 9.3)
docker pull postgres:9.3
POSTGRES_CONTAINER=`docker run -d --name postgres postgres:9.3`
# Wait for the postgres port to be available
until nc -z $(docker inspect --format='{{.NetworkSettings.IPAddress}}' $POSTGRES_CONTAINER) 5432
do
    echo "waiting for postgres container..."
    sleep 0.5
done
docker run --link postgres:postgres -e "DJANGO_DB_HOST=postgres" -e "DJANGO_DB_NAME=postgres" -e "DJANGO_DB_USER=postgres" $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG python3 manage.py migrate --noinput
APP_CONTAINER=`docker run -d -p 80:80 --name review_circleci_app --link postgres:postgres -e "DJANGO_STATIC_URL=http://127.0.0.1:8080/" -e "DJANGO_ALLOWED_HOST=127.0.0.1" -e "DJANGO_DB_HOST=postgres" -e "DJANGO_DB_NAME=postgres" -e "DJANGO_DB_USER=postgres" $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG`
STATIC_CONTAINER=`docker run -d -p 8080:80 --name review_circleci_static $DOCKERHUB_STATIC_IMAGE_NAME:$DOCKERHUB_STATIC_IMAGE_TAG`
set +e
npm run protractor
EXIT_STATUS=$?
docker rm $(docker stop $STATIC_CONTAINER $APP_CONTAINER $POSTGRES_CONTAINER)
exit $EXIT_STATUS
