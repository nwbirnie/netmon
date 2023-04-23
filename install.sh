#!/bin/bash
set -euox pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
docker/prometheus/install.sh
docker/blackbox_exporter/install.sh
docker/fastcom/install.sh

read -p 'Enter grafana service account credential: ' grafana_credential
export grafana_credential
cat <<EOF | sudo bash
cp -r usr/* /usr
cp -r etc/* /etc
mkdir -p /var/prometheus/secret
echo "${grafana_credential}" > /var/prometheus/secret/grafana.credential
chmod a+w /var/prometheus
systemctl enable blackbox.service
systemctl enable fastcom.service
systemctl enable prometheus.service
EOF

