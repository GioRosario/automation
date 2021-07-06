docker build . -t conda
docker create -ti --name temp conda bash
docker cp temp:/build .
read -p 'Enter Quay.io username: ' uservar
read -p 'Enter repository name: ' reposvar
read -sp 'Enter Quay.io password: ' passvar
echo $passvar > ~/password.txt
cat ~/my_password.txt | docker login quay.io --username $uservar --password-stdin
docker commit temp quay.io/$uservar/$reposvar
docker push quay.io/$uservar/$reposvar
docker rm -f temp
docker image rm conda
docker image rm quay.io/$uservar/$reposvar
