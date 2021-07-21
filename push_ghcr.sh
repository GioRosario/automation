#!/bin/bash

echo $PAT | docker login ghcr.io --username $GIT_USERNAME --password-stdin
docker tag $timestamp_holder ghcr.io/$GIT_USERNAME/$timestamp_holder
docker image push ghcr.io/$GIT_USERNAME/$timestamp_holder

docker rmi $latest_holder
docker rmi $timestamp_holder
docker rmi ghcr.io/$GIT_USERNAME/$timestamp_holders
