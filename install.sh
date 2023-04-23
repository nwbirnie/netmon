#!/bin/bash
set -euox pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
docker/prometheus/install.sh
docker/blackbox_exporter/install.sh
docker/fastcom/install.sh
cp -r usr/* /usr
cp -r etc/* /etc
mkdir -p /var/prometheus
chmod a+w /var/prometheus
