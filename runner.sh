#!/bin/bash
set -e

sudo touch requirements.txt
user=nsls2
image="condaforge"
timestamp=$(date +%Y%m%d%H%M%S)
env_name="nsls2-analysis-2021-1.2"
#docker build . -t conda --target build
#docker build . -t temp-image --target export
#docker image build . -t $user/${image}:latest \
 #                  -t $user/${image}:${timestamp}
#docker run -it --rm -v $PWD:/build $user/${image}:${timestamp} bash -l /build/export.sh
#docker create -ti --name temp-container temp-image bash
#docker cp temp-container:/build .
sudo chown -v $USER: ${env_name}.tar.gz ${env_name}-sha256sum.txt ${env_name}.yml
exit 1

echo $QUAY_PASS > ~/password.txt
cat ~/password.txt | docker login quay.io --username $QUAY_USER --password-stdin
docker commit temp quay.io/$QUAY_REPOS
docker push quay.io/$QUAY_REPOS
docker rm -f temp-container
docker image rm $user/${image}:latest
#docker image rm temp-image

#user=nsls2
#image="condaforge"
#timestamp=$(date +%Y%m%d%H%M%S)
#docker image build . -t $user/${image}:latest \
