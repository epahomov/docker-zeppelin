FROM epahomov/docker-spark:spark_2.0_hadoop_2.6

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

LABEL version="zep_0.6.2_java_8_spark_2.1.0_hadoop_2.6"

ARG ZEPPELIN_VERSION="v0.6.2"
ARG SPARK_ZEPPELIN_VERSION="2.0"
ARG MAJOR_HADOOP_VERSION="2.6"

WORKDIR /zeppelin

ENV SPARK_HIVE true
ENV ZEPPELIN_HOME /zeppelin

RUN ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java

RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('knitr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('rJava', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('RJDBC', repos = 'http://cran.us.r-project.org')"

RUN git clone --depth 1 --branch ${ZEPPELIN_VERSION} https://github.com/apache/zeppelin.git /zeppelin && \
    apt-get update && \
    apt-get install -y maven && \
    mvn  -Pscala-2.11 -Pspark-${SPARK_ZEPPELIN_VERSION} -Phadoop-${MAJOR_HADOOP_VERSION} -Psparkr -Pyarn -Ppyspark -DskipTests -Pvendor-repo clean package && \
    apt-get install -y python-matplotlib && \
    echo "tail -F /zeppelin/logs/*" >> bin/zeppelin-daemon.sh && \
    mkdir ~/.config/matplotlib && \
    echo "backend : Agg" >> ~/.config/matplotlib/matplotlibrc

EXPOSE 8080 7077

CMD ["/zeppelin/bin/zeppelin-daemon.sh","start"]