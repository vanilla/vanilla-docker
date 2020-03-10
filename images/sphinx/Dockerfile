FROM vanillaryan/sphinxsearch

RUN yum install epel-release mysql mysql-devel python3 socat cronie -y

# Systemd compatibility fix under CentOS
COPY ./systemctl3.py /usr/bin/systemctl
RUN chmod 755 /usr/bin/systemctl

RUN ["mkdir", "-p", "/usr/local/etc/sphinx"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/conf.d"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/data"]

COPY ./root/* /root/
COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt

RUN chmod +x /root/*.sh
RUN chmod +x /root/listen.9399.sh
RUN /root/install-sphinx-cron.sh

CMD /root/startup.sh

EXPOSE 9312 9306 9399
