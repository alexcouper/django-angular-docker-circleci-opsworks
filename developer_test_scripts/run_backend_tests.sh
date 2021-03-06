#!/bin/bash
set -e
echo "Running PEP8 checks"
docker-compose run --rm app pep8 --show-source --exclude=migrations,settings.py,manage.py .
echo "Running django-nose tests"
docker-compose run --rm app python3 -Wall manage.py test --noinput --exe --nocapture $@
