image="conda"
timestamp=$(date +%Y%m%d%H%M%S)
docker build -t $image:$timestamp .
docker create -ti --name conda conda bash
docker cp conda:/build .
echo $QUAY_PASS > ~/password.txt
cat ~/password.txt | docker login quay.io --username $QUAY_USER --password-stdin
docker commit temp quay.io/$QUAY_REPOS
docker push quay.io/$QUAY_REPOS
docker rm -f conda
docker rmi $image:$timestamp
docker image rm quay.io/$QUAY_REPOS
