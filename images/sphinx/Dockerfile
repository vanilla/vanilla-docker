FROM leodido/sphinxsearch:2.2.10

COPY ./usr/local/etc/sphinx.conf, /usr/local/etc/sphinx.conf
COPY ./usr/local/etc/sphinx/searchd.conf, /usr/local/etc/sphinx/searchd.conf
COPY ./usr/local/etc/sphinx/conf.d, /usr/local/etc/sphinx/conf.d
COPY ./usr/local/etc/sphinx/data/stops.txt, /usr/local/etc/sphinx/data/stops.txt

ENTRYPOINT

CMD indexer --all && searchd --nodetach

EXPOSE 9312
