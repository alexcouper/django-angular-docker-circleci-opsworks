#!/bin/bash
set -e

echo "Running PEP8 checks"
pep8 --exclude=migrations,settings.py,manage.py .

echo "Running django-nose tests"
python3 -Wall manage.py test --noinput --exe --nocapture $@
