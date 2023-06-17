#/bin/bash
set -euo pipefail

read -p 'Enter grafana user name: ' grafana_user
read -p 'Enter grafana access policy token: ' grafana_credential
read -p 'Enter grafana URL: ' grafana_url

set -x

export grafana_credential grafana_url grafana_user

at <<EOF | sudo bash
set -euox pipefail
cp -r usr/* /usr
cp -r etc/* /etc
mkdir -p /var/prometheus/secret
mkdir -p /var/prometheus/data
chmod a+w -R /var/prometheus/data
echo "${grafana_credential}" > /var/prometheus/secret/grafana.credential
sed "s/INSERT_USER/${grafana_user}/" -i /usr/local/share/netmon/prometheus.yml
sed "s,INSERT_URL,${grafana_url}," -i /usr/local/share/netmon/prometheus.yml
chmod a+w /var/prometheus
systemctl enable blackbox.service
systemctl enable fastcom.service
systemctl enable prometheus.service
systemctl restart blackbox.service
systemctl restart fastcom.service
systemctl restart prometheus.service
EOF
