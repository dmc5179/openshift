#!/bin/bash
set -x

mkdir -p /omnisci-storage/sds

/omnisci/bin/omnisci_sd_server --port 6277 --path /omnisci-storage/sds

