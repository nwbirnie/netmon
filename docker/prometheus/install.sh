#!/bin/bash
set -euox pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
prom_dir="$(mktemp -d)"

curl -L -o "${prom_dir}"/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.43.0%2Bstringlabels/prometheus-2.43.0+stringlabels.linux-armv6.tar.gz
tar zxvf "${prom_dir}"/prometheus.tar.gz --strip-components=1 -C "${prom_dir}"
cp Dockerfile "${prom_dir}"
cd "${prom_dir}"
docker build -t nick/prometheus:latest .

