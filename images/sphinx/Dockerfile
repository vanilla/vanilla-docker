FROM leodido/sphinxsearch:2.2.10

RUN ["mkdir", "-p", "/usr/local/etc/sphinx"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/conf.d"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/data"]

COPY ./root/* /root/
COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt

RUN chmod +x /root/startup.sh

CMD /root/startup.sh

EXPOSE 9312
