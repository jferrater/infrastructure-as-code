FROM alpine:3.9

RUN apk add apache2 php7-apache2 php7-mongodb curl --update-cache --no-cache            

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log && \
    mkdir -p /run/apache2/ && \
    rm /var/www/localhost/htdocs/*

COPY ["index.php", "/var/www/localhost/htdocs/"]
ENV MONGO_CS="mongodb://localhost:27017"

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
 