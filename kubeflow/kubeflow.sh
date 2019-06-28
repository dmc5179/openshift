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
oc adm policy add-scc-to-user anyuid -z jupyter-notebook -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z jupyter-web-app -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z katib-ui -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z meta-controller-service -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z metrics-collector -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z ml-pipeline-scheduledworkflow -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z notebook-controller -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z pipeline-runner -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z pytorch-operator -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z studyjob-controller -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z tf-job-dashboard -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z tf-job-operator -n${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z vizier-core -n${NAMESPACE}




