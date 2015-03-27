FROM    ubuntu:14.04

MAINTAINER Pakhomov Egor <pahomov.egor@gmail.com>

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java7-installer oracle-java7-set-default
RUN apt-get -y install maven
RUN apt-get -y install git
RUN apt-get -y install npm
RUN git clone https://github.com/apache/incubator-zeppelin.git
RUN cd incubator-zeppelin \
	git reset --hard a007a9b5f235ebd9c608a005c5243503291d94d5

ADD warm_maven.sh /usr/local/bin/warm_maven.sh
RUN /usr/local/bin/warm_maven.sh 

EXPOSE 8080
