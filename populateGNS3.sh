declare ADDRESS=$(virsh --quiet -c $HOST domifaddr $VM | sed -E "s/.*ipv.? *(.*)\/.*/\1/")
declare HTTP_ADDRESS=http://$ADDRESS
declare HTTP_API=$HTTP_ADDRESS/v2
declare PROJECT=test

echo ADDRESS: $ADDRESS
echo HTTP_ADDRESS: $HTTP_ADDRESS
echo HTTP_API: $HTTP_API

#curl $HTTP_API/version
JQ_PROJECT_ID() {
    declare INPUT="${@:- $(cat /dev/stdin)}"
    echo $INPUT | \
        jq -r '.[] | select(.name=="test")|.project_id' \
        || echo $INPUT | jq -r '.project_id'
}
declare PROJECT_ID="$(curl --silent $HTTP_API/projects | JQ_PROJECT_ID)"

if [[ -z $PROJECT_ID ]]; then
    echo "Project not yet created"
    curl -X POST $HTTP_API/projects -d '{"name": "test"}' | JQ_PROJECT_ID
    # PROJECT_ID=$(curl -X POST $HTTP_API/projects -d '{"name": "test"}' | JQ_PROJECT_ID)
fi

echo Current Project ID: $PROJECT_ID

declare APPLIANCES=$(curl $HTTP_API/appliances?update=yes)
# curl $HTTP_API/projects | jq "{project_id}"
