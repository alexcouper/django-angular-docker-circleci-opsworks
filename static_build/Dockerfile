FROM ubuntu:trusty

RUN apt-get update && apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /usr/share/nginx/html/index.html
COPY collected_static /usr/share/nginx/html
WORKDIR /etc/nginx
RUN echo 'OK, thanks' > /usr/share/nginx/html/health.html
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
EXPOSE 80
