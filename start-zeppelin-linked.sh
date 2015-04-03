#!/usr/bin/env bash
docker pull epahomov/docker-zeppelin
docker run -i -t -p 8080:8080 -p 8081:8081 --link spark_master:spark_master epahomov/docker-zeppelin /start-script.sh
