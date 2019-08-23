#!/bin/bash

export NAMESPACE=gitlab

oc project ${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z default -n ${NAMESPACE}
oc adm policy add-scc-to-user anyuid -z gitlab-runner -n ${NAMESPACE}

# Bug https://gitlab.com/charts/gitlab/issues/1192
oc adm policy add-scc-to-group anyuid system:authenticated -n ${NAMESPACE}

kubectl create -f https://gitlab.com/charts/gitlab/raw/master/doc/installation/examples/rbac-config.yaml
helm init --service-account tiller

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --tiller-namespace=${NAMESPACE} --install gitlab gitlab/gitlab \
  --timeout 600 \
  ### OCP options needed
  --set nginx-ingress.enabled=false \
￼ #
  --set global.hosts.domain=dan.redhatgov.io \
  # At some point I'll test it with an external postgres repo
  # made with the chruncy operator
  #--set postgresql.install=false \
  #--set global.psql.host=production.postgress.hostname.local \
  #--set global.psql.password.secret=kubernetes_secret_name \
  #--set global.psql.password.key=key_that_contains_postgres_password \
  # Configure community edition instead of enterprise
  --set global.edition=ce \
  # External object storage
  #--set global.minio.enabled=false \
  # At some point I'll have to follow:
  # https://docs.gitlab.com/charts/advanced/external-object-storage/index.html
  # TLS options (for now use self signed)
  --set certmanager.install=false \
  --set global.ingress.configureCertmanager=false \
  --set gitlab-runner.install=false \
  --set certmanager.rbac.create=false \
  --set nginx-ingress.rbac.createRole=false \
  --set prometheus.rbac.create=false \
  --set gitlab-runner.rbac.create=false



#./helm upgrade --tiller-namespace=${NAMESPACE} --install gitlab gitlab/gitlab   --timeout 600   --set nginx-ingress.enabled=false   --set global.hosts.domain=dan.redhatgov.io   --set global.edition=ce   --set certmanager.install=false   --set global.ingress.configureCertmanager=false   --set gitlab-runner.install=false   --set certmanager.rbac.create=false   --set nginx-ingress.rbac.createRole=false   --set prometheus.rbac.create=false   --set gitlab-runner.rbac.create=false 
