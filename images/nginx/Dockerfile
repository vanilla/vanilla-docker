# Pull base image.
FROM nginx:1.13

COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/nginx/fastcgi.conf.tpl /etc/nginx/fastcgi.conf.tpl

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
RUN ln -s /srv/vanilla-repositories/stub-sso-providers /srv/sso
