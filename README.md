Docker container for zeppelin
=================================

This repository with [docker](https://www.docker.io/) image of [Apache Zeppelin](https://zeppelin.apache.org/).

To run zeppelin from script, execute:
```
docker run -d -p 8080:8080 -p 7077:7077 -p 4040:4040 epahomov/docker-zeppelin
```

Zeppelin would be on port 8080. 

General idea's about possible use case scenarios are in [spark base image](https://hub.docker.com/r/epahomov/docker-spark/)

