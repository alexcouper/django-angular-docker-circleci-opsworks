FROM ubuntu:trusty

# Basic package setup
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-wsgi-py3 \
    python3.4 \
    python3-pip \
    python3-psycopg2
# Prep codebase and Python packages
COPY review /srv/review
WORKDIR /srv/review
RUN pip3 install -r requirements/base.txt -r requirements/test.txt
# Configure Apache
COPY apache.vhost /etc/apache2/sites-available/000-review.conf
RUN a2enmod wsgi && a2ensite 000-review && a2dissite 000-default
# Set up the load balancer's "health PING"
RUN echo 'OK, thanks' > /var/www/html/health.html
# Go
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
