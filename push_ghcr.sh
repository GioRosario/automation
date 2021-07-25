#!/bin/bash

echo $GITHUB_TOKEN | docker login ghcr.io --username $GITHUB_USERNAME --password-stdin
docker tag $timestamp_holder ghcr.io/$GITHUB_USERNAME/$timestamp_holder
docker image push ghcr.io/$GITHUB_USERNAME/$timestamp_holder

docker rmi ghcr.io/$GITHUB_USERNAME/$timestamp_holders
