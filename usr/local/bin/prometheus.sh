#!/bin/bash
docker run \
  --rm \
  -p 9090:9090 
  -v /usr/local/share/netmon/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v /var/prometheus:/prometheus \
  prom/prometheus --storage.tsdb.retention.size=1GB
