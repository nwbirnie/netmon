#!/bin/bash
docker run \
  -p 9090:9090 
  -v /usr/local/share/netmon/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v prometheus_data:/prometheus \
  prom/prometheus --storage.tsdb.retention.size=1GB