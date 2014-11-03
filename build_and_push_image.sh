#!/bin/bash
set -e
function usage()
{
cat << EOF
usage: $0 type

Build the indicated type of Docker image and push this up to Dockerhub.

type = "app" or "static"
EOF
}
TYPE=$1
case $TYPE in
    app)
        docker build -t $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG .
        docker push $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG
        ;;
    static)
        docker build -t $DOCKERHUB_STATIC_IMAGE_NAME:$DOCKERHUB_STATIC_IMAGE_TAG static_build/
        docker push $DOCKERHUB_STATIC_IMAGE_NAME:$DOCKERHUB_STATIC_IMAGE_TAG
        ;;
    ?)
        usage
        exit
        ;;
esac
