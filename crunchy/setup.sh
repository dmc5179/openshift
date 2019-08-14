#!/bin/bash
set -x

export OPERATOR_NAMESPACE=pgo
export CLUSTER_NAME=ais-pg-cluster

export INSTALLER_DIR=$PWD

oc new-project pgo
oc project pgo

# Add this to the inventory vars area
#ansible_ssh_private_key_file=/home/ec2-user/.ssh/dan-redhatgov-io.pem
#ansible_connection=ssh
#ansible_user=ec2-user
#ansible_become=yes
#ansible_become_method=sudo
#ansible_become_user=root

if [ ! -d postgres-operator ];
then
  git clone https://github.com/CrunchyData/postgres-operator.git
else
  echo "operator already checked out"
fi

cd ./postgres-operator/ansible

ansible-playbook -i "${INSTALLER_DIR}/inventory" --tags=install  main.yml

# OpenShift
oc get deployments -n ${OPERATOR_NAMESPACE}
oc get pods -n ${OPERATOR_NAMESPACE}

cat <<EOF >> ~/.bashrc
export PGOUSER="${HOME?}/.pgo/${OPERATOR_NAMESPACE}/pgouser"
export PGO_CA_CERT="${HOME?}/.pgo/${OPERATOR_NAMESPACE}/client.crt"
export PGO_CLIENT_CERT="${HOME?}/.pgo/${OPERATOR_NAMESPACE}/client.crt"
export PGO_CLIENT_KEY="${HOME?}/.pgo/${OPERATOR_NAMESPACE}/client.pem"
export PGO_APISERVER_URL='https://127.0.0.1:8443'
export PGO_NAMESPACE=$OPERATOR_NAMESPACE
EOF

source ~/.bashrc


# How does this work when the pods will change names if it cycles????
# OK...this sets up a port forward from my local machine into the cluster. What??
# This will lock up your terminal unless you use &
export OPERATOR_POD_NAME=$(oc get pods -n pgo | awk '{print $1}' | tail -1)

# This port forward is to use the pgo command and do things like create a cluster
#oc port-forward "${OPERATOR_POD_NAME}" -n "${OPERATOR_NAMESPACE}" 8443:8443

# Unless you configure the operator to manage other namespaces
# You have to build your cluster in the same pgo namespace
#pgo create cluster ${CLUSTER_NAME} --replica-count=1 -n ${OPERATOR_NAMESPACE}


# This port forward is to use the psql command to talk to the database itself
#oc port-forward "${OPERATOR_POD_NAME}" -n "${OPERATOR_NAMESPACE}" 15432:5432
# psql -h 127.0.0.1 -p 15432 .........

sleep 5
oc expose svc/${CLUSTER_NAME}

