FROM elasticsearch:2.3.4
MAINTAINER Jonathan Roizin <joroizin@gmail.com>

ENV ELASTICSEARCH_ANALYSIS_HEBREW_VERSION 2.3.4

COPY hspell-data-files /var/lib/hspell-data-files 

# install hebmorph plugin
RUN plugin install https://bintray.com/synhershko/elasticsearch-analysis-hebrew/download_file?file_path=elasticsearch-analysis-hebrew-$ELASTICSEARCH_ANALYSIS_HEBREW_VERSION.zip
