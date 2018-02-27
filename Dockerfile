FROM elasticsearch:5.3.0-alpine
MAINTAINER Jonathan Roizin <joroizin@gmail.com>

# install hspell data files,
# hebmorph requirement
ENV HEBMORPH_VERSION 5.3.0
ENV HEBMORPH_FILE hebmorph-lucene-$HEBMORPH_VERSION
ENV ELASTICSEARCH_ANALYSIS_HEBREW_VERSION 5.3.0
ENV xpack.security.enabled=false
ENV xpack.monitoring.enabled=false
ENV path.data=/elasticsearch-persistent-data/

#USER root
RUN apk add --update --no-cache sudo 
RUN mkdir -p /elasticsearch-persistent-data/ && chown elasticsearch.elasticsearch /elasticsearch-persistent-data/ -R && chmod a+w -R /elasticsearch-persistent-data/
RUN echo '%root ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/root
RUN addgroup elasticsearch root

RUN echo vm.max_map_count=262144 > /etc/sysctl.d/01-es.conf 
RUN echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml

ADD startup.sh /

COPY hspell-data-files /var/lib/hspell-data-files

# RUN elasticsearch-plugin remove x-pack
# install hebmorph plugin
RUN elasticsearch-plugin install --verbose https://bintray.com/synhershko/elasticsearch-analysis-hebrew/download_file?file_path=elasticsearch-analysis-hebrew-$ELASTICSEARCH_ANALYSIS_HEBREW_VERSION.zip

#USER elasticsearch


EXPOSE 9200

ENTRYPOINT ["/startup.sh"]
