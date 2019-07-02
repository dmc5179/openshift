#!/bin/bash
set -x

if [ ! -e /omnisci-storage/data ] ; then 
  mkdir -p /omnisci-storage/data
  /omnisci/bin/initdb -f --data /omnisci-storage/data --skip-geo
fi

echo '[{\"host\": \"mapd-sds\", \"port\": 6277, \"role\": \"string\"}, {\"host\": \"mapd-leafa\", \"port\": 6274, \"role\": \"dbleaf\"}]' > /omnisci-storage/cluster.conf

echo > /omnisci-storage/omnisci.conf << EOF
port = 6274
http-port = 6278
calcite-port = 6279
data = "/omnisci-storage/data"
read-only = false
num-gpus = 1
cluster = "/omnisci-storage/cluster.conf"

[web]
port = 6273
frontend = "/prod/omnisci/frontend"

EOF

/omnisci/bin/omnisci_server /omnisci-storage/data --config /omnisci-storage/omnisci.conf

