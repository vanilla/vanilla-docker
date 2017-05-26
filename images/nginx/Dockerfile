# Pull base image.
FROM nginx:latest

COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./etc/nginx/cert/ssl.self.pem /etc/nginx/cert/ssl.self.pem
COPY ./etc/nginx/cert/ssl.self.key /etc/nginx/cert/ssl.self.key

# Sites
COPY ./etc/nginx/sites-enabled/sso.dev.conf /etc/nginx/sites-enabled/sso.dev.conf
COPY ./etc/nginx/sites-enabled/vanilla.dev.conf /etc/nginx/sites-enabled/vanilla.dev.conf
COPY ./etc/nginx/sites-enabled/vanilla.test.conf /etc/nginx/sites-enabled/vanilla.test.conf

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs
RUN ln -s /srv/vanilla-repositories/vanilla_unittests /srv/htdocs-test
RUN ln -s /srv/vanilla-repositories/internal/login /srv/sso
