FROM registry.tlmewarnercable.com:8443/mesos22-java7:master-1
MAINTAINER "Paul Otto" <paul@ottoops.com>

# Ensure everything uses oraclejdk
RUN update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

VOLUME /shared
VOLUME /kafka.logs

# Define working directory.
WORKDIR /opt

RUN git clone https://github.com/potto007/kafka

WORKDIR /opt/kafka

RUN \
    git checkout feature/fix-framework && \
    ./gradlew jar && \
        ln -s /shared/kafka_2.10-0.8.2.1.tgz

# Define default command.
CMD ["./kafka-mesos.sh","scheduler","/shared/kafka-mesos.properties"]