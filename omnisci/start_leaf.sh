#!/bin/bash
set -x

if [ ! -e /omnisci-storage/data ] ; then 
  mkdir -p /omnisci-storage/data 
  /omnisci/bin/initdb -f --data /omnisci-storage/data --skip-geo 
fi

echo '[{\"host\": \"omnisci-sds\", \"port\": 6277, \"role\": \"string\"}]' > /omnisci-storage/cluster.conf

echo > /omnisci-storage/omnisci.conf << EOF
port = 6274
http-port = 6278
calcite-port = 6279
data = "/omnisci-storage/nodeLocal/data"
read-only = false
string-servers = "/omnisci-storage/cluster.conf"
EOF

/omnisci/bin/omnisci_server /omnisci-storage/data --config /omnisci-storage/omnisci.conf --verbose

