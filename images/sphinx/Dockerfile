FROM leodido/sphinxsearch:2.2.10

RUN ["mkdir", "-p", "/usr/local/etc/sphinx"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/conf.d"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/data"]

COPY ./root/* /root/
#COPY ./root/startup.sh /root/startup.sh
#COPY ./root/index.all.sh /root/index.all.sh
#COPY ./root/index.delta.sh /root/index.delta.sh

COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt

RUN chmod +x /root/startup.sh

CMD /root/startup.sh

EXPOSE 9312
EXPOSE 9306
