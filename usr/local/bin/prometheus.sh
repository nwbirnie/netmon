#!/bin/bash
docker run \
  --rm \
  -p 9090:9090 \
  -v /usr/local/share/netmon/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v /var/prometheus:/prometheus \
  -v /var/prometheus/secret/grafana.credential:/grafana.credential \
  nick/prometheus:latest --storage.tsdb.retention.size=1GB --config.file=/etc/prometheus/prometheus.yml
