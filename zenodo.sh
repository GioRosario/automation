set -e
read -p 'Enter Zenodo Token: ' TOKEN
DEPOSITION=$( echo $1 | sed 's+^http[s]*://sandbox.zenodo.org/deposit/++g' )
FILEPATH=$2
FILENAME=$(echo $FILEPATH | sed 's+.*/++g')

BUCKET=$(curl -H @<(echo -e "Accept: application/json\nAuthorization: Bearer $TOKEN") "https://www.sandbox.zenodo.org/api/deposit/depositions/$DEPOSITION" | jq --raw-output .links.bucket)
curl --progress-bar -o /dev/null -H @<(echo -e "Authorization: Bearer $TOKEN") --upload-file $FILEPATH $BUCKET/$FILENAME
