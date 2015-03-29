Docker container for zeppelin
=================================

This repository contains a set of scripts and configuration files to run a [Apache Zeppelin(incubating)](https://zeppelin.incubator.apache.org/) from [Docker](https://www.docker.io/) containers.

To run zeppelin:

Pull container:
	docker pull epahomov/docker-zeppelin

Run container: 
	docker run -i -t -p 8080:8080 -p 8081:8081 epahomov/docker-zeppelin /bin/bash

Currently Zeppelin do not support -P version due to websocket functionality. There is [ticket](https://issues.apache.org/jira/browse/ZEPPELIN-10) for it.

Go to zeppelin folder and build with you hadoop and spark version. 
Out of the box it build with
	mvn clean package -Pspark-1.2.1 -Dhadoop.version=2.2.0 -Phadoop-2.2 -Pyarn -DskipTests

Different build versions you can see on [zeppelin site](https://zeppelin.incubator.apache.org/docs/install/install.html)

Run zeppelin by executing:
	/incubator-zeppelin/bin/zeppelin-daemon.sh start

For all zeppelin realted documentation, please see zeppelin [official documentation](https://zeppelin.incubator.apache.org/docs/index.html).
