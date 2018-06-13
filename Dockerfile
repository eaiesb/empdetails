FROM eaiesbhub/mule39ce:latest

ARG MULE_HOME=/root/mule-standalone-3.9.0

ENV MULE_HOME=${MULE_HOME} \
    PATH=$PATH:$MULE_HOME/bin
    
#Deploying the empdetails.zip to mule apps directory
  
ADD ./empdetails.zip /root/mule-standalone-3.9.0/apps/

RUN chmod -R 777 /root/

VOLUME [ "/root/mule-standalone-3.9.0/apps"]

ENTRYPOINT ${MULE_HOME}/bin/mule && /bin/bash

# Default http port

EXPOSE 8081 8082 8084 9091
