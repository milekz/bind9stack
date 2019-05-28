#!/bin/bash

tar -czvf config.tar.gz ./bind/*

RANDOM=$(< /dev/urandom tr -dc A-Za-z | head -c16) \
sed  "s/bind_config/bind_config${RANDOM}/g" docker-compose.yml  > docker-compose.tmp

SYSYLOG_DST=10.1.1.1 \
SYSYLOG_FACILITY=local3 \
docker stack up -c docker-compose.tmp bind

rm docker-compose.tmp 
rm config.tar.gz