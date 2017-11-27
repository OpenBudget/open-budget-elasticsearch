#!/bin/sh

sudo chown elasticsearch.elasticsearch -R /elasticsearch-persistent-data/
sudo chmod a+w -R /elasticsearch-persistent-data/

/bin/bash bin/es-docker
