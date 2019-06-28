#!/bin/bash

NAMESPACE=kubeflow

oc new-project ${NAMESPACE}
oc project ${NAMESPACE}

# Set permissions for service accounts

oc adm policy add-scc-to-user anyuid -z ambassador -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z argo -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z argo-ui -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z builder -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z centraldashboard -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z default -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z deployer -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z jupyter -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z jupyter-notebook -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z jupyter-web-app -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z katib-ui -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z meta-controller-service -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z metrics-collector -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline-persistenceagent -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline-scheduledworkflow -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline-ui -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline-viewer-crd-service-account -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z notebook-controller -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z pipeline-runner -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z profiles -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z pytorch-operator -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z spartakus -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z studyjob-controller -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z tf-job-dashboard -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z tf-job-operator -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z vizier-core -n${NAMESPACE}


export KUBEFLOW_SRC=kubeflow
export KUBEFLOW_TAG=v0.5-branch
mkdir ${KUBEFLOW_SRC}
cd ${KUBEFLOW_SRC}
curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
export KFAPP=openshift
scripts/kfctl.sh init ${KFAPP} --platform none
../scripts/kfctl.sh generate k8s
export NAMESPACE=kubeflow
../scripts/kfctl.sh apply k8s

