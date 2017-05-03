# Pull base image.
FROM nginx:latest

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY etc/nginx/sites-enabled/default.conf /etc/nginx/sites-enabled/default.conf

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
