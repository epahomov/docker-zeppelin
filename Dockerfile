FROM epahomov/docker-spark:spark_2.0_hadoop_2.6

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

LABEL version="zep_0.6.2_java_8_spark_2.1.0_hadoop_2.6"

ARG ZEPPELIN_VERSION="v0.6.2"
ARG SPARK_ZEPPELIN_VERSION="2.0"
ARG MAJOR_HADOOP_VERSION="2.6"

RUN git clone --depth 1 --branch ${ZEPPELIN_VERSION} https://github.com/apache/zeppelin.git /zeppelin

WORKDIR /zeppelin

ENV SPARK_HIVE true

RUN apt-get update
RUN apt-get install -y maven
RUN mvn -Pspark-${SPARK_ZEPPELIN_VERSION} -Phadoop-${MAJOR_HADOOP_VERSION} -Pyarn -Ppyspark -DskipTests -Pvendor-repo clean package

ENV ZEPPELIN_HOME /zeppelin

RUN apt-get install -y python-matplotlib

# Otherwise there would be no process for docker to understand, that something is running
RUN echo "tail -F /zeppelin/logs/*" >> bin/zeppelin-daemon.sh
RUN mkdir ~/.config/matplotlib
RUN echo "backend : Agg" >> ~/.config/matplotlib/matplotlibrc
EXPOSE 8080 7077

CMD ["/zeppelin/bin/zeppelin-daemon.sh","start"]