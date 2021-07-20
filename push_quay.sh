#!/bin/bash

docker run -it --name extra-container $timestamp_holder
echo $QUAY_PASSWORD | docker login quay.io -u $QUAY_USERNAME --password-stdin
docker commit extra-container quay.io/$QUAY_REPO
docker push quay.io/$QUAY_REPO
docker rm extra-container
docker image rm quay.io/$QUAY_REPO

#docker rmi $latest_holder
#docker rmi $timestamp_holder
