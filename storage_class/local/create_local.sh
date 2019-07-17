#!/bin/bash

# Before running these commands
# Make sure the EBS volume is mounted to the host in the right path
# And SELinux has been updated

oc new-project local-storage
oc create serviceaccount local-storage-admin
oc adm policy add-scc-to-user privileged -z local-storage-admin
oc create -f https://raw.githubusercontent.com/openshift/origin/release-3.11/examples/storage-examples/local-examples/local-storage-provisioner-template.yaml
oc create -f local_volume_cm.yaml 
oc new-app -p CONFIGMAP=local-volume-config -p SERVICE_ACCOUNT=local-storage-admin -p NAMESPACE=local-storage -p PROVISIONER_IMAGE=registry.redhat.io/openshift3/local-storage-provisioner:v3.11   local-storage-provisioner

oc create -f ./storage-class-ssd.yaml

