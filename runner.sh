#!/bin/bash
set -e

sudo touch requirements.txt
user=nsls2
image="nsls2-analysis-2021-1.2"
timestamp=$(date +%Y%m%d%H%M%S)
env_name="nsls2-analysis-2021-1.2"
docker image build . -t $user/${image}:latest \
                     -t $user/${image}:${timestamp}
docker run -it --rm -v $PWD:/build $user/${image}:${timestamp} bash -l /build/export.sh
sudo chown -v $USER: ${env_name}.tar.gz ${env_name}-sha256sum.txt ${env_name}.yml

latest_holder="$user/${image}:latest"
timestamp_holder="$user/${image}:${timestamp}"
export latest_holder
export timestamp_holder

## Push to Quay
# chmod +x push_quay.sh
# ./push_quay.sh

## Push to Dockerhub
#chmod +x push_dockerhub.sh
#./push_dockerhub.sh

## Push to GHCR
# chmod +x push_ghcr.sh
# ./push_ghcr.sh
