# review-app

This is the Django project which provides the App Service for the Review App.

## Containers

From this repository, 2 Docker containers are built:

### onetouchapps/review-app

This is a production-ready Apache process hooked up to the Django WSGI module.

### onetouchapps/review-static

This is the collected static files from across the Django project, packaged
into a folder structure and served up by nginx.

## Environment Variables

For the various phases of this project's delivery cycle to function correctly,
certain environment variables need to be made available to the running
context...

### Django tests and Django dev server

  - *DJANGO_TEST_MODE* should be '1' to indicate that this is test mode (and
    also to activate Django DEBUG mode)

### review-app WSGI application

  - *DJANGO_ALLOWED_HOST* This is required to match the HOST of an http request
    which is to be serviced by the WSGI (Django) app

  - *DJANGO_STATIC_URL* For production systems, this env var should be set to
    the prefix of the delivery URL for static files. If not present in the env
    vars, defaults to ``/static/``.

### CI environment

  - *AWS_ACCESS_KEY_ID* and *AWS_SECRET_ACCESS_KEY* IAM keypair with the
    rights to run ``create_deployment`` API tasks at OpsWorks

  - *OW_APP_STACK_ID* and *OW_APP_APP_ID* IDs for the OpsWork app which runs
    the review-app containers

  - *OW_STATIC_STACK_ID* and *OW_STATIC_APP_ID* IDs for the OpsWork app which
    runs the review-static containers

  - *DOCKERHUB_API_URL*, *DOCKERHUB_EMAIL* and *DOCKERHUB_AUTH* URL and
    credentials for an account with rights to push to both the review-app and
    review-static repositories at Dockerhub

  - *DOCKERHUB_APP_IMAGE_NAME* and *DOCKERHUB_APP_IMAGE_TAG* typically
    "onetouchapps/review-app" and "latest", respectively

  - *DOCKERHUB_STATIC_IMAGE_NAME* and *DOCKERHUB_STATIC_IMAGE_TAG* typically
    "onetouchapps/review-static" and "latest", respectively
