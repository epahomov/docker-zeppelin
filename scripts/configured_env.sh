#!/usr/bin/env bash
export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`

sed '1d' /etc/hosts > tmpHosts
cat tmpHosts > /etc/hosts
rm tmpHosts

export MASTER=spark://${SPARK_MASTER_PORT_7077_TCP_ADDR}:${SPARK_MASTER_ENV$
cd incubator-zeppelin/
/bin/bash
