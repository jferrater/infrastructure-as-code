#!/bin/bash

JENKINS_HOME='jenkins_home'
JENKINS_CONTAINER='jenkins'

if [ ! -d "$JENKINS_HOME" ] 
then
    echo "Creating jenkins_home directory." 
    mkdir $JENKINS_HOME
fi


# 192.168.65.1 is the IP to the host 
#( output of : route | awk '/^default/ { print $2 }' 
#when running docker run --network host )
if [ ! "$(docker ps -q -f name=$JENKINS_CONTAINER)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$JENKINS_CONTAINER)" ]; then
        # cleanup
        docker rm $JENKINS_CONTAINER
    fi
    docker run -dit \
        -v jenkins_home:/var/jenkins_home \
        -p 8080:8080 \
        -p 50000:50000 \
        --name $JENKINS_CONTAINER \
        --add-host="localhost:192.168.65.1" \
        jenkins/jenkins:lts-jdk11
fi

