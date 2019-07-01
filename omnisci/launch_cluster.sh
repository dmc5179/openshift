#!/bin/bash

oc create configmap mapd-cm-sds     --from-file=start_sds.sh
oc create configmap mapd-cm-aggr    --from-file=start_aggr.sh
oc create configmap mapd-cm-leaf    --from-file=start_leaf.sh
oc create configmap mapd-cm-immerse --from-file=start_immerge.sh

