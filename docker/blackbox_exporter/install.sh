#!/bin/bash
set -euox pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
bb_dir="$(mktemp -d)"

curl -L -o "${bb_dir}"/blackbox_exporter.tar.gz https://github.com/prometheus/blackbox_exporter/releases/download/v0.23.0/blackbox_exporter-0.23.0.linux-armv6.tar.gz

tar zxvf "${bb_dir}"/blackbox_exporter.tar.gz --strip-components=1 -C "${bb_dir}"
cp Dockerfile "${bb_dir}"
cd "${bb_dir}"
docker build -t nick/blackbox_exporter:latest .

