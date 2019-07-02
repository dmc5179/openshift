#!/bin/bash

oc create configmap mapd-cm-sds     --from-file=start_sds.sh
oc create configmap mapd-cm-aggr    --from-file=start_aggr.sh
oc create configmap mapd-cm-leaf    --from-file=start_leaf.sh
oc create configmap mapd-cm-immerse --from-file=start_immerse.sh

oc create configmap omnisci-conf-cm --from-file=omnisci.conf
oc create configmap omnisci-agg-conf-cm --from-file=omnisci-agg.conf

oc create -f mapd_aggr_pvc.yaml
oc create -f mapd_immerse_pvc.yaml
oc create -f mapd_leaf-a_pvc.yaml
oc create -f mapd_sds_pvc.yaml


