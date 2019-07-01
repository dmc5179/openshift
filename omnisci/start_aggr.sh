#!/bin/bash

if [ ! -e /omnisci-storage/data ] ; then 
  mkdir -p /omnisci-storage/data
  /omnisci/bin/initdb -f --data /omnisci-storage/data --skip-geo
fi

echo '[{\"host\": \"mapd-sds\", \"port\": 6277, \"role\": \"string\"}, {\"host\": \"mapd-leaf1\", \"port\": 6274, \"role\": \"dbleaf\"}, {\"host\": \"mapd-leaf2\", \"port\": 6274, \"role\": \"dbleaf\"}]' > /omnisci-storage/cluster.conf

/omnisci/bin/omnisci_server /omnisci-storage/data --config /omnisci-storage/omnisci.conf --cluster /omnisci-storage/cluster.conf

