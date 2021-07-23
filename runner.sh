#!/bin/bash

set -e

image="nsls2-analysis-2021-1.2"
timestamp=$(date +%Y%m%d%H%M%S)
env_name="nsls2-analysis-2021-1.2"

if [ -f "${image}.tar.gz" ]; then
    echo -e "File ${image}.tar.gz exists. Move it or remove it before proceeding."
    exit 1
fi

docker image build . -t ${image}:latest \
                     -t ${image}:${timestamp}
docker run -it --rm -v $PWD:/build ${image}:${timestamp} bash -l /build/export.sh
sudo chown -v $USER: ${env_name}.tar.gz ${env_name}-sha256sum.txt ${env_name}.yml

read -p "To how many repositories would you like to upload the Docker image? (enter a numerical value from 0 - 3) " VALUE

if [ $VALUE -gt 3 -o $VALUE -lt 0 ]; then
  echo "Invalid entry."
  exit 1
fi

while [ $VALUE -gt 0 ]; do
    read -p "To which repository would you like to upload? (Enter 'ghcr', 'dockerhub', or 'quay') " REPO
    if [ "$REPO" == "ghcr" ]; then
        echo $GITHUB_TOKEN | docker login ghcr.io --username $GITHUB_USERNAME --password-stdin
        docker tag ${image}:${timestamp} ghcr.io/$GITHUB_USERNAME/${image}:${timestamp}
        docker image push ghcr.io/$GITHUB_USERNAME/${image}:${timestamp}
    elif [ "$REPO" == "dockerhub" ]; then
        echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin
        docker tag ${image}:${timestamp} $DOCKER_REPO
        docker push $DOCKER_REPO
    elif [ "$REPO" == "quay" ]; then
        docker create --name extra-container ${image}:${timestamp}
        echo $QUAY_PASSWORD | docker login quay.io -u $QUAY_USERNAME --password-stdin
        docker commit extra-container quay.io/$QUAY_REPO
        docker push quay.io/$QUAY_REPO
        docker rm extra-container
        docker image rm quay.io/$QUAY_REPO
    else
        echo "Invalid entry."
        exit 1
    fi
    VALUE=$(( $VALUE - 1 ))
    done

read -p "Would like to upload the file to Zenodo? " ZEN
if [ "$ZEN" == "yes" -o "$ZEN" == "y" ]; then
    python3 -m zenodo_upload
fi

docker rmi $latest_holder
docker rmi $timestamp_holder
