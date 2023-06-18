#/bin/bash
set -euo pipefail

[[ ! -z "${grafana_user}" ]] || read -p 'Enter grafana user name: ' grafana_user
[[ ! -z "${grafana_credential}" ]] || read -p 'Enter grafana access policy token: ' grafana_credential
[[ ! -z "${grafana_url}" ]] || read -p 'Enter grafana URL: ' grafana_url

set -x

export grafana_credential grafana_url grafana_user

cat <<EOF | sudo bash
set -euox pipefail
cp -r usr/* /usr
cp -r etc/* /etc
mkdir -p /var/prometheus/secret
mkdir -p /var/prometheus/data
chown nobody:nogroup -R /var/prometheus

useradd -s /usr/sbin/nologin netmon || true
usermod -G docker netmon || true

echo "${grafana_credential}" > /var/prometheus/secret/grafana.credential
sed "s/INSERT_USER/${grafana_user}/" -i /usr/local/share/netmon/prometheus.yml
sed "s,INSERT_URL,${grafana_url}," -i /usr/local/share/netmon/prometheus.yml
systemctl enable blackbox.service
systemctl enable fastcom.service
systemctl enable prometheus.service
systemctl restart blackbox.service
systemctl restart fastcom.service
systemctl restart prometheus.service
EOF
