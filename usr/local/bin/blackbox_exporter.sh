#!/bin/bash
docker run --rm -p 9115:9115 -v /usr/local/share/netmon/blackbox_config.yml:/config/blackbox_config.yml quay.io/prometheus/blackbox-exporter:latest --config.file=/config/blackbox_config.yml
