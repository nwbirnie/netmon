#!/bin/bash
set -euox pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
docker/prometheus/install.sh
docker/blackbox_exporter/install.sh
docker/fastcom/install.sh
sudo cp -r usr/* /usr
sudo cp -r etc/* /etc
sudo mkdir -p /var/prometheus
sudo chmod a+w /var/prometheus
sudo systemctl enable blackbox.service
sudo systemctl enable fastcom.service
sudo systemctl enable prometheus.service
