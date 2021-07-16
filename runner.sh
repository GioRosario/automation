#!/bin/bash

sudo touch requirements.txt
user=nsls2
image="condaforge"
timestamp=$(date +%Y%m%d%H%M%S)
#docker build . -t conda --target build
#docker build . -t temp-image --target export
docker image build . -t $user/${image}:latest \
                   -t $user/${image}:${timestamp}
docker create -ti --name temp-container $user/${image}:latest
#docker create -ti --name temp-container temp-image bash
docker cp temp-container:/build .
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
                  # -t $user/${image}:${timestamp}

#docker run -it --name runner $user/${image}:latest
#docker run -it prac2.sh
#docker run -it --name dry-run $user/${image}:latest
