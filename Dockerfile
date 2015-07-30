FROM ubuntu:trusty

# Basic package setup
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-wsgi-py3 \
    python3.4 \
    python3-pip \
    python3-psycopg2

# Prep codebase and Python packages
# Copy across things that aren't likely to change but require processing time first.
RUN mkdir /srv/review
COPY requirements /srv/review/requirements
WORKDIR /srv/review
RUN pip3 install -r requirements/base.txt -r requirements/test.txt
# Then copy across the rest so that we don't have to pip install every time we change a file.
COPY review /srv/review
# Configure Apache
COPY apache.vhost /etc/apache2/sites-available/000-review.conf
RUN a2enmod wsgi && a2ensite 000-review && a2dissite 000-default
# Copy the AWS RDS cert authority bundle
COPY rds/rds-combined-ca-bundle.pem /etc/ssl/certs/rds-combined-ca-bundle.pem
# Set up the load balancer's "health PING"
RUN echo 'OK, thanks' > /var/www/html/health.html
# Go
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
