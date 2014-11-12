#!/bin/bash
set -e
docker run $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG pep8 --show-source --exclude=migrations,settings.py,manage.py .
docker run -e "DJANGO_TEST_MODE=1" $DOCKERHUB_APP_IMAGE_NAME:$DOCKERHUB_APP_IMAGE_TAG python3 -Wall manage.py test --noinput --exe --nocapture
