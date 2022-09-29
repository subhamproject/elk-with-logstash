#!/bin/bash

#waiting for other elk server to be up
wait_for_elastic.sh "${ELASTIC_SERVERS}"

if [ -f /data/user_details.txt ];then
export ES_PASSWORD=$(cat /data/user_details.txt |grep -w "elastic"|grep PASSWORD|cut -d'=' -f2|tr -d ' ')
envsubst < /tmp/filebeat.yml > /etc/filebeat/filebeat.yml
fi

chown root:root /etc/filebeat/filebeat.yml

chmod go-w /etc/filebeat/filebeat.yml


filebeat setup --index-management -E output.logstash.enabled=true

service filebeat start

tail -f /dev/null
