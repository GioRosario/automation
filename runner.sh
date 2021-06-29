docker build . -t conda
docker create -ti --name temp conda bash
docker cp temp:/build .
docker rm -f temp
