#!/bin/bash
set -x

oc new-project jupyter-hub
oc project jupyter-hub

oc adm policy add-scc-to-user anyuid -z default

oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/master/image-streams/s2i-minimal-notebook.json

#oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyterhub-quickstart/master/image-streams/jupyterhub.json
# Use the RHEL image
oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyterhub-quickstart/master/build-configs/jupyterhub.json

oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyterhub-quickstart/master/templates/jupyterhub-builder.json
oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyterhub-quickstart/master/templates/jupyterhub-deployer.json
oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyterhub-quickstart/master/templates/jupyterhub-

oc new-app --template jupyterhub-deployer

# If you want to monitor the deployment
#oc rollout status dc/jupyterhub

# Get the route that was created
# oc get route/jupyterhub

