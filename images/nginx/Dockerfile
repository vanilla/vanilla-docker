# Pull base image.
FROM nginx:1.13

COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./etc/nginx/cert/ssl.self.pem /etc/nginx/cert/ssl.self.pem
COPY ./etc/nginx/cert/ssl.self.key /etc/nginx/cert/ssl.self.key

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
RUN ln -s /srv/vanilla-repositories/vanilla_unittests /srv/htdocs-test
RUN ln -s /srv/vanilla-repositories/stub-sso-providers /srv/sso
