#/bin/bash
set -euo pipefail

[[ ! -z "${grafana_user}" ]] || read -p 'Enter grafana user name: ' grafana_user
[[ ! -z "${grafana_credential}" ]] || read -p 'Enter grafana access policy token: ' grafana_credential
[[ ! -z "${grafana_url}" ]] || read -p 'Enter grafana URL: ' grafana_url

set -x

export grafana_credential grafana_url grafana_user

cat <<EOF | sudo bash
set -euox pipefail

cp bin/* /usr/local/bin
cp config/systemd/* /etc/systemd/system

mkdir -p /etc/netmon
chmod 755 -R /etc/netmon
cp config/scrapers/* /etc/netmon

mkdir -p /var/prometheus/secret
mkdir -p /var/prometheus/data
chown nobody:nogroup -R /var/prometheus
chmod 755 -R /var/prometheus

useradd -s /usr/sbin/nologin netmon || true
usermod -G docker netmon || true

echo "${grafana_credential}" > /var/prometheus/secret/grafana.credential
sed "s/INSERT_USER/${grafana_user}/" -i /usr/local/share/netmon/prometheus.yml
sed "s,INSERT_URL,${grafana_url}," -i /usr/local/share/netmon/prometheus.yml
chmod 400 /var/prometheus/secret/grafana.credential

systemctl enable blackbox.service fastcom.service prometheus.service
systemctl restart blackbox.service fastcom.service prometheus.service
EOF
