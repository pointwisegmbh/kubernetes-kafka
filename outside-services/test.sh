#!/usr/bin/env bash

function join_by { local IFS="$1"; shift; echo "$*"; }

BOOTSTRAP_ARRAY=()
POD_NAME_ARRAY=("kafka-0" "kafka-1" "kafka-2" "kafka-3" "kafka-4" "kafka-5" "kafka-6" "kafka-7")
for POD_NAME in "${POD_NAME_ARRAY[@]}"
do
  BOOTSTRAP_IP=$(kubectl get pods ${POD_NAME} -n kafka -o jsonpath='{.metadata.annotations.kafka-listener-outside-host}')
  BOOTSTRAP_PORT=$(kubectl get pods ${POD_NAME} -n kafka -o jsonpath='{.metadata.annotations.kafka-listener-outside-port}')
  BOOTSTRAP_ARRAY+=("$BOOTSTRAP_IP:$BOOTSTRAP_PORT")
done

BOOTSTRAP=$(join_by , "${BOOTSTRAP_ARRAY[@]}")
echo $BOOTSTRAP
#docker run --rm -t solsson/kafkacat -C -b $BOOTSTRAP -t test-basic-with-kafkacat -o -10
#docker run --rm -t solsson/kafkacat -C -b $BOOTSTRAP -t heapster-metrics