FROM java:8

ARG VERSION=0.166

RUN apt-get update && \
    apt-get install -y python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /opt/presto && \
    curl https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${VERSION}/presto-server-${VERSION}.tar.gz -o presto-server.tar.gz && \
    tar -zxvf presto-server.tar.gz -C /opt/presto --strip-components=1 && \
    rm presto-server.tar.gz

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${VERSION}/presto-cli-${VERSION}-executable.jar /usr/local/bin/presto

RUN chmod a+x /usr/local/bin/presto

RUN mkdir /opt/presto/data

ADD /etc /opt/presto/etc

EXPOSE 8080

ENTRYPOINT ["/opt/presto/bin/launcher", "run"]
