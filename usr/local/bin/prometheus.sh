#!/bin/bash
docker run \
  --rm \
  -p 9090:9090 \
  -v /usr/local/share/netmon/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v /var/prometheus/data:/prometheus \
  -v /var/prometheus/secret/grafana.credential:/grafana.credential \
  -v /etc/ssl/certs:/etc/ssl/certs \
  --add-host=host.docker.internal:host-gateway \
  nick/prometheus:latest --storage.tsdb.retention.size=1GB --config.file=/etc/prometheus/prometheus.yml
