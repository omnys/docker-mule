FROM alpine as builder

WORKDIR  /tmp

RUN wget https://repository-master.mulesoft.org/nexus/service/local/repositories/releases/content/org/mule/distributions/mule-standalone/3.9.0/mule-standalone-3.9.0.zip && \
  unzip mule-standalone-3.9.0.zip

FROM openjdk:8u222-stretch

# Define working directory.
WORKDIR /opt/mule

COPY --from=builder /tmp/mule-standalone-3.9.0 .
RUN useradd -m mule && \
  chown -R mule /opt/mule

USER mule

# Define mount points.
VOLUME ["/opt/mule/logs", "/opt/mule/conf", "/opt/mule/apps", "/opt/mule/domains"]

# Default http port
EXPOSE 8081

CMD [ "./bin/mule" ]
