#!/bin/bash

set -e

user=nsls2
image="nsls2-analysis-2021-1.2"
timestamp=$(date +%Y%m%d%H%M%S)
env_name="nsls2-analysis-2021-1.2"

if [ -f "nsls2-analysis-2021-1.2.tar.gz" ]
then
        read -p "These tar.gz and yml files already exist. Would you like to replace the existing files? " REPLACE
        if [ "$REPLACE" == 'yes' ] || [ "$REPLACE" == 'y' ]
                then rm nsls2-analysis-2021-1.2.tar.gz;rm nsls2-analysis-2021-1.2.yml;rm nsls2-analysis-2021-1.2-sha256sum.txt;echo "Old files have been removed."
        elif [ "$REPLACE" == 'no' ] || [ "$REPLACE" == 'n' ]
                then mkdir nsls2-analysis-2021-1.2-old-${timestamp};mv nsls2-analysis-2021-1.2.tar.gz nsls2-analysis-2021-1.2-old-${timestamp};
                     mv nsls2-analysis-2021-1.2.yml nsls2-analysis-2021-1.2-old-${timesstamp};mv nsls2-analysis-2021-1.2-sha256sum.txt nsls2-analysis-2021-1.2-old-${timestamp};
                     echo "A directory has been created and the old files have been moved into this directory."
        fi
fi

docker image build . -t $user/${image}:latest \
                     -t $user/${image}:${timestamp}
docker run -it --rm -v $PWD:/build $user/${image}:${timestamp} bash -l /build/export.sh
sudo chown -v $USER: ${env_name}.tar.gz ${env_name}-sha256sum.txt ${env_name}.yml

export latest_holder="$user/${image}:latest"
export timestamp_holder="$user/${image}:${timestamp}"

## Push to Quay
#chmod +x push_quay.sh
#./push_quay.sh

## Push to Dockerhub
#chmod +x push_dockerhub.sh
#./push_dockerhub.sh

## Push to GHCR
#chmod +x push_ghcr.sh
#./push_ghcr.sh

docker rmi $latest_holder
docker rmi $timestamp_holder
