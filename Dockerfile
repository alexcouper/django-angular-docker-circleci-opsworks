FROM ubuntu:trusty
RUN apt-get update && apt-get install -y \
    apache2 \
    python3.4 \
    python3-pip
COPY review /srv/review
WORKDIR /srv/review
RUN pip3 install -r requirements/base.txt
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
