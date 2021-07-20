#!/bin/bash

echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin
docker tag $timestamp_holder $DOCKER_REPO
docker push $DOCKER_REPO

#docker rmi $latest_holder
#docker rmi $timestamp_holder
