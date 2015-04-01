#!/usr/bin/env bash
docker pull epahomov/docker-zeppelin
docker run -d -t -p 8000:8000 -p 8001:8001 --link spark_master:spark_master epahomov/docker-zeppelin /start-script.sh
