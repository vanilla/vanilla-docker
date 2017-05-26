# Pull base image.
FROM httpd:latest

COPY ./usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
