FROM ubuntu:trusty

RUN apt-get update && apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY collected_static /usr/share/nginx/html
WORKDIR /etc/nginx

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
EXPOSE 80
