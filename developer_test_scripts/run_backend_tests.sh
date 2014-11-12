#!/bin/bash
set -e
echo "Running PEP8 checks"
fig run app pep8 --show-source --exclude=migrations,settings.py,manage.py .
echo "Running django-nose tests"
fig run app python3 -Wall manage.py test --noinput --exe --nocapture $@
