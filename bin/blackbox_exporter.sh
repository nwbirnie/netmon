#!/bin/bash
docker run \
  --rm \
  --name blackbox \
  -p \
  9115:9115 \
  -v /etc/netmon/blackbox_config.yml:/config/blackbox_config.yml \
  nick/blackbox_exporter:latest \
  --config.file=/config/blackbox_config.yml 
