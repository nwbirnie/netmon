#!/bin/bash
set -euox pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"
fc_dir="$(mktemp -d)"

curl -L -o "${fc_dir}"/fastcom.tar.gz https://github.com/caarlos0/fastcom-exporter/archive/refs/tags/v1.3.3.tar.gz

tar zxvf "${fc_dir}"/fastcom.tar.gz --strip-components=1 -C "${fc_dir}"
cp Dockerfile "${fc_dir}"
cd "${fc_dir}"
CGO_ENABLED=0 go build
docker build -t nick/fastcom_exporter:latest .


