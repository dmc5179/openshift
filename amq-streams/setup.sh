#!/bin/bash

NAMESPACE=amq-streams

oc new-project amq-streams

oc project amq-streams

oc adm policy add-scc-to-user anyuid -z strimzi-cluster-operator -n ${NAMESPACE}

oc adm policy add-scc-to-user anyuid -z default -n ${NAMESPACE}

oc apply -f strimzi/install/cluster-operator -n ${NAMESPACE}
sleep 10
oc apply -f strimzi/examples/templates/cluster-operator -n ${NAMESPACE}


