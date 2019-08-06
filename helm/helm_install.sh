#!/bin/bash
NAMESPACE=tiller

# Download and unpack help
#mkdir helm
#cd helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz
tar -xzf helm-v2.14.1-linux-amd64.tar.gz
cd linux-amd64

oc new-project ${NAMESPACE}
oc project ${NAMESPACE}
oc adm policy add-role-to-user admin -z tiller
oc adm policy add-scc-to-group anyuid -z default

# rbac-config defaults to using the kube-system namespace so we have to use sed first
wget  https://gitlab.com/charts/gitlab/raw/master/doc/installation/examples/rbac-config.yaml
sed -i "s/kube-system/${NAMESPACE}/g" ./rbac-config.yaml
oc create -f ./rbac-config.yaml
helm init --service-account tiller

