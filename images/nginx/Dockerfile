# Pull base image.
FROM nginx:1.13

COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
RUN ln -s /srv/vanilla-repositories/vanilla_unittests /srv/htdocs-test
RUN ln -s /srv/vanilla-repositories/stub-sso-providers /srv/sso
