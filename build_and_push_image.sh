#!/bin/bash
set -e
function usage()
{
cat << EOF
usage: $0 type

Build the indicated type of Docker image and push this up to Dockerhub.

type = "static", currently.
EOF
}
TYPE=$1
case $TYPE in
    static)
        docker build -t $DOCKERHUB_STATIC_IMAGE_NAME:$DOCKERHUB_STATIC_IMAGE_TAG static_build/
        docker push $DOCKERHUB_STATIC_IMAGE_NAME:$DOCKERHUB_STATIC_IMAGE_TAG
        ;;
    ?)
        usage
        exit
        ;;
esac
