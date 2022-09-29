#!/bin/bash

#waiting for other elk server to be up
wait_for_elastic.sh "${ELASTIC_SERVERS}"

if [ -f /data/user_details.txt ];then
export ES_PASSWORD=$(cat /data/user_details.txt |grep -w "elastic"|grep PASSWORD|cut -d'=' -f2|tr -d ' ')
export LS_PASSWORD=$(cat /data/user_details.txt |grep -w "logstash_system"|grep PASSWORD|cut -d'=' -f2|tr -d ' ')
envsubst < /tmp/logstash.yml > /etc/logstash/logstash.yml
envsubst < /tmp/logs.conf > /etc/logstash/conf.d/logs.conf
fi

exec /usr/share/logstash/bin/logstash

tail -f /dev/null
