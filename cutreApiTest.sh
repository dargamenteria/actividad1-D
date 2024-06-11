#/bin/bash

endpoint="https://${1}.execute-api.us-east-1.amazonaws.com"
#endpoint="https://bmvkmge31l.execute-api.us-east-1.amazonaws.com"

echo "GET the collection"
curl -sX POST "${endpoint}/Prod/todos" --data '{ "text": "Learn Serverless" }' | jq

echo "Get all items"
curl -sX GET "${endpoint}/Prod/todos" | jq
echo "Items: $(curl -sX GET "${endpoint}/Prod/todos" | jq '.|length')"

id=$(curl -sX GET "${endpoint}/Prod/todos" | jq '.[0].id' | tr -d '"')

echo "Get one specific item"
curl -sX GET "${endpoint}/Prod/todos/${id}" | jq

echo "Update one to have a snake"
curl -sX PUT "${endpoint}/Prod/todos/${id}" --data '{ "text": "Learn python and more", "checked": true }' echo
echo "Items: $(curl -sX GET "${endpoint}/Prod/todos" | jq '.|length')"
echo "There are $(curl -sX GET "${endpoint}/Prod/todos" | grep 'python' | wc -l)  snakes in the collection "

echo "Delete one snake"
curl -X DELETE "${endpoint}/Prod/todos/${id}"
echo

curl -sX GET "${endpoint}/Prod/todos" | jq
echo "Items: $(curl -sX GET "${endpoint}/Prod/todos" | jq '.|length')"
echo "There are $(curl -sX GET "${endpoint}/Prod/todos" | grep 'python' | wc -l)  snakes in the collection "
