# Pull base image.
FROM httpd:2.4

COPY ./usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
