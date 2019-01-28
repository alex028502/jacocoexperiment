#! /usr/bin/env bash

set -e

cd $(dirname $0)

IMAGE_NAME=jacoco-experiment
COMMAND="$0 $@"

function build {
    set -x
    docker build . -t $IMAGE_NAME
}

function run {
    if [[ "$1" == "" ]];
    then
      echo usage: $COMMAND port\#
      exit 1
    fi
    set -x
    docker run $_EXTRA_OPTIONS -p $1:8080 $IMAGE_NAME
}

function coverage {
    _EXTRA_OPTIONS='-e JAVA_OPTS=javaagent:/usr/local/tomcat/jacoco-agent.jar'
    run $@
}

function attach {
    docker run -it $IMAGE_NAME /bin/bash
}

$@
