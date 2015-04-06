FROM    ubuntu:14.04

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java7-installer oracle-java7-set-default

ENV MAVEN_VERSION 3.3.1
RUN apt-get -y install curl
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN apt-get -y install git
RUN apt-get -y install npm
RUN git clone https://github.com/apache/incubator-zeppelin.git
RUN cd incubator-zeppelin \
	git reset --hard 2498e5df12ae8cc1b24375e253df94394710aaf8

ADD warm_maven.sh /usr/local/bin/warm_maven.sh
ADD scripts/start-script.sh /start-script.sh
ADD scripts/configured_env.sh /configured_env.sh
RUN /usr/local/bin/warm_maven.sh 

EXPOSE 8080 8081
