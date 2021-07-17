#!/bin/bash
set -e

sudo touch requirements.txt
user=nsls2
image="condaforge"
timestamp=$(date +%Y%m%d%H%M%S)
env_name="nsls2-analysis-2021-1.2"
docker image build . -t $user/${image}:latest \
                   -t $user/${image}:${timestamp}
docker run -it --rm -v $PWD:/build $user/${image}:${timestamp} bash -l /build/export.sh
sudo chown -v $USER: ${env_name}.tar.gz ${env_name}-sha256sum.txt ${env_name}.yml

docker run -it --name quay-container $user/${image}:latest
echo $QUAY_PASSWORD > ~/password.txt
cat ~/password.txt | docker login quay.io --username $QUAY_USERNAME --password-stdin
docker commit quay-container quay.io/$QUAY_REPO
docker push quay.io/$QUAY_REPO

docker container rm quay-container
docker rmi $user/${image}:latest
docker rmi $user/${image}:${timestamp}
docker image rm quay.io/$QUAY_USERNAME/$QUAY_REPO
