#!/bin/bash
docker run --rm -p 9115:9115 -v /usr/local/share/netmon:/config quay.io/prometheus/blackbox-exporter:latest --config.file=/config/blackbox_config.yml
