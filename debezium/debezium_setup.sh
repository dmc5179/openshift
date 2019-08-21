#!/bin/bash

# These steps for creating the cluster come from
# the debezium docs and when I ran them I get errors about kafka
# not being able to find a leader. Try just using the strimzi yaml
# to provision the kafka cluster and kafka connect cluster

# Deploy an ephemeral single instance Kafka broker
oc new-app strimzi-ephemeral -p CLUSTER_NAME=broker -p ZOOKEEPER_NODE_COUNT=1 -p KAFKA_NODE_COUNT=1 -p KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 -p KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1

# Deploy a single instance of Kafka Connect with no plug-in installed
oc new-app strimzi-connect-s2i -p CLUSTER_NAME=debezium -p KAFKA_CONNECT_BOOTSTRAP_SERVERS=broker-kafka-bootstrap:9092 -p KAFKA_CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR=1 -p KAFKA_CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR=1 -p KAFKA_CONNECT_STATUS_STORAGE_REPLICATION_FACTOR=1 -p KAFKA_CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE=false -p KAFKA_CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE=false

# Build a Debezium image
export DEBEZIUM_VERSION=0.10.0.Beta4
mkdir -p plugins && cd plugins && \
for PLUGIN in {mongodb,mysql,postgres}; do \
    curl http://central.maven.org/maven2/io/debezium/debezium-connector-$PLUGIN/$DEBEZIUM_VERSION/debezium-connector-$PLUGIN-$DEBEZIUM_VERSION-plugin.tar.gz | tar xz; \
done && \
oc start-build debezium-connect --from-dir=. --follow && \
cd .. && rm -rf plugins


# Use either debezium_connect_mysql or debezium_connect_postgresql to install connector
# make sure to customize it for your database

# Also update and run what is in debezium_monitoring
