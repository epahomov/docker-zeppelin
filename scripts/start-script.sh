#!/usr/bin/env bash
/setup_env.sh
export MASTER=spark://${SPARK_MASTER_PORT_7077_TCP_ADDR}:${SPARK_MASTER_ENV_SPARK_MASTER_PORT}
./bin/zeppelin-daemon.sh start
/bin/bash
