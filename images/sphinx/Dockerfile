FROM leodido/sphinxsearch:2.2.10

#RUN yum localinstall -y --nogpgcheck  http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#RUN yum install -y socat
RUN yum install sed
RUN yum install -y epel-release
RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
#RUN yum install -y yum-plugin-ov
RUN yum clean all && yum install -y compat-readline5
RUN yum clean all && yum install -y socat
 # && yum update -y

RUN ["mkdir", "-p", "/usr/local/etc/sphinx"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/conf.d"]
RUN ["mkdir", "-p", "/usr/local/etc/sphinx/data"]

COPY ./root/* /root/
#COPY ./root/startup.sh /root/startup.sh
COPY ./root/index.all.sh /root/index.all.sh
#COPY ./root/index.delta.sh /root/index.delta.sh

COPY ./usr/local/etc/sphinx.conf /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/data/stops.txt /usr/local/etc/sphinx/data/stops.txt

RUN chmod +x /root/startup.sh \
 && chmod +x /root/listen.9399.sh

CMD /root/startup.sh

EXPOSE 9312
EXPOSE 9306
EXPOSE 9399
