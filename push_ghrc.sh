#!/bin/bash
echo $PAT | docker login ghcr.io --username $GIT_USERNAME --password-stdin
docker tag $timestamp_holder ghrc.io/$GIT_REPO
docker image push ghrc.io/$GIT_REPO

#docker rmi $latest_holder
#docker rmi $timestamp_holder
