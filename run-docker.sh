#!/usr/bin/env bash

CONTAINER_ID=$(docker run -u zap -p 2376:2376 -d owasp/zap2docker-weekly zap.sh -daemon -port 2376 -host 127.0.0.1 -config api.disablekey=true -config scanner.attackOnStart=true -config view.mode=attack -config connection.dnsTtlSuccessfulQueries=-1 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true)

# the target URL for ZAP to scan
TARGET_URL=$1

docker exec $CONTAINER_ID zap-cli -p 2376 status -t 120 && docker exec $CONTAINER_ID zap-cli -p 2376 open-url $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2376 spider $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2376 active-scan -r $TARGET_URL

docker exec $CONTAINER_ID zap-cli -p 2376 alerts

# docker logs [container ID or name]
divider==================================================================
printf "\n"
printf "$divider"
printf "ZAP-daemon log output follows"
printf "$divider"
printf "\n"

docker logs $CONTAINER_ID > ZAPScanResults.txt

docker stop $CONTAINER_ID
