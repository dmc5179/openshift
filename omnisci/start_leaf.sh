#!/bin/bash

if [ ! -e /omnisci-storage/data ] ; then 
  mkdir -p /omnisci-storage/data 
  /omnisci/bin/initdb -f --data /omnisci-storage/data --skip-geo 
fi

echo '[{\"host\": \"sds\", \"port\": 6277, \"role\": \"string\"}]' > /omnisci-storage/cluster.conf
/omnisci/bin/omnisci_server /omnisci-storage/data --config /omnisci-storage/omnisci.conf --string-servers /omnisci-storage/cluster.conf

