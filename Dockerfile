FROM docker.elastic.co/elasticsearch/elasticsearch:5.3.0
MAINTAINER Jonathan Roizin <joroizin@gmail.com>

# install hspell data files,
# hebmorph requirement
ENV HEBMORPH_VERSION 5.3.0
ENV HEBMORPH_FILE hebmorph-lucene-$HEBMORPH_VERSION
ENV ELASTICSEARCH_ANALYSIS_HEBREW_VERSION 5.3.0
ENV xpack.security.enabled=false

USER root
RUN echo vm.max_map_count=262144 > /etc/sysctl.d/01-es.conf # sysctl -w vm.max_map_count=262144

USER elasticsearch

COPY hspell-data-files /var/lib/hspell-data-files
# install hebmorph plugin
RUN elasticsearch-plugin install --verbose https://bintray.com/synhershko/elasticsearch-analysis-hebrew/download_file?file_path=elasticsearch-analysis-hebrew-$ELASTICSEARCH_ANALYSIS_HEBREW_VERSION.zip

EXPOSE 9200
