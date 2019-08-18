#!/bin/bash
set -x

/omnisci/bin/omnisci_web_server --data /tmp --backend-url "http://mapd-aggr:6278"

