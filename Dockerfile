FROM epahomov/docker-spark:spark_2.0_hadoop_2.6

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

LABEL version="anchorfree"

ARG ZEPPELIN_VERSION="ZEPPELIN-1922"
ARG SPARK_ZEPPELIN_VERSION="2.0"
ARG MAJOR_HADOOP_VERSION="2.6"

WORKDIR /zeppelin

ENV SPARK_HIVE true
ENV ZEPPELIN_HOME /zeppelin

RUN git clone --depth 1 --branch ${ZEPPELIN_VERSION} https://github.com/epahomov/incubator-zeppelin.git /zeppelin && \
    apt-get update && \
    apt-get install -y maven && \
    mvn  -Pscala-2.11 -Pspark-${SPARK_ZEPPELIN_VERSION} -Phadoop-${MAJOR_HADOOP_VERSION} -Psparkr -Pyarn -Ppyspark -DskipTests -Pvendor-repo clean package && \
    apt-get install -y python-matplotlib && \
    echo "tail -F /zeppelin/logs/*" >> bin/zeppelin-daemon.sh && \
    mkdir ~/.config/matplotlib && \
    echo "backend : Agg" >> ~/.config/matplotlib/matplotlibrc

EXPOSE 8080 7077

CMD ["/zeppelin/bin/zeppelin-daemon.sh","start"]