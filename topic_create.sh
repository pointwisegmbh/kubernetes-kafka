#!/bin/bash
# prior to running the script make sure you have zookeeper at 2181
# k port-forward pzoo-0 2181 2181
topics=( "apps-json" "http-raw-collekt-data-v2" "http-raw-data-v2" "pixel-data" "postback-data" "push-notifications" "records-all" "records-collekt-all" "records-locations" "user-profile" )
partitions=( 16 16 16 16 16 16 16 16 16 16 )
replicas=( 3 3 3 3 3 3 3 3 3 3 )

for ((i=0;i<${#topics[@]};++i)); do
    printf "%s partitions: %s replicas: %s %s\n" "${topics[i]}" "${partitions[i]}" "${replicas[i]}"
    ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor ${replicas[i]} --partitions ${partitions[i]} --topic ${topics[i]}
done
