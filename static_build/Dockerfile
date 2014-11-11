FROM ubuntu:trusty

# Basic package setup
RUN apt-get update && apt-get install -y nginx
# Configure nginx
WORKDIR /etc/nginx
RUN echo "daemon off;" >> nginx.conf
RUN sed -i 's@/var/log/nginx/\(access\|error\)\.log@/dev/stdout@g;' /etc/nginx/nginx.conf
# Remove default index page
RUN rm /usr/share/nginx/html/index.html
# Copy static assets into place
COPY collected_static /usr/share/nginx/html
# Set up the load balancer's "health PING"
RUN echo 'OK, thanks' > /usr/share/nginx/html/health.html
# Go
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
EXPOSE 80
