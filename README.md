# review-app

This is the Django project which provides the App Service for the Review App.

## Containers

From this repository, 2 Docker containers are built:

### onetouchapps/review-app

This is a production-ready Apache process hooked up to the Django WSGI module.

### onetouchapps/review-static

This is the collected static files from across the Django project, packaged
into a folder structure and served up by nginx.

## Development mode

Local dependencies:

  - [Docker](https://docs.docker.com/installation/#installation)

  - [Fig](http://www.fig.sh/install.html)

Once your dependencies are set up, Django / backend tests may be run from your
host with:

``fig build`` - if you haven't already done so, then

``developer_test_scripts/run_backend_tests.sh``

To run the BDD tests which will drive the code, written in Jasmine and
executed (in dev) against the Django dev server, you need to have all the node
depenencies set up locally:

``nvm install``

Then you can run the BDD tests with:

``./run_developer_tests.sh``

This script takes care of starting and stopping the Django dev server for you.
Note you will need the APP_SERVICE_URL environment variable set (see below)

## Environment Variables

For the various phases of this project's delivery cycle to function correctly,
certain environment variables need to be made available to the running
context...

### Django tests and Django dev server

  - *DJANGO_TEST_MODE* should be '1' to indicate that this is test mode and
    also to activate Django DEBUG mode. (Note: this is already set up for you
    if you are using Fig as outlined above.)

### Developer tests

  - *APP_SERVICE_URL* should point to the open dev server port on your Fig
    container's IP address (If you are running boot2docker you can get this
    with ``boot2docker ip``)

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

  - *DOCKER_LOG_ROUTER_IMAGE_NAME* the Docker image which contains the log
    router (which is currently Logspout)

  - *LOG_AGGREGATE_HOST* and *LOG_AGGREGATE_PORT* the hostname and port of the
    log aggregation service

### Production environment

  - *DJANGO_DB_HOST*, *DJANGO_DB_NAME*, *DJANGO_DB_USER*, *DJANGO_DB_PASSWORD*
    location of and credentials for a (Postgres) database instance for this app
    (in the CI environment these are not needed in the environment, since they
    are passed in as part of the Docker container-linking process in
    circle.yml)
