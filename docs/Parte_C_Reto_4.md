-   [Reto 4 -- Verificación
    API](#reto-4-verificación-api)
    -   [Ejecución de los comandos CURL para verificar toda nuestra API
        Rest:](#ejecución-de-los-comandos-curl-para-verificar-toda-nuestra-api-rest)
    -   [Error](#error)
    -   [Diff del método](#diff-del-método)

# Reto 4 -- Verificación API

## Ejecución de los comandos CURL para verificar toda nuestra API Rest:

No queda mucho tiempo y para no complicarme la vida vamos crear un
miniscript en bash para realizar test del api.

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
    curl -sX PUT "${endpoint}/Prod/todos/${id}" --data '{ "text": "Learn python and more", "checked": true }'
    echo "Items: $(curl -sX GET "${endpoint}/Prod/todos" | jq '.|length')"
    echo "There are $(curl -sX GET "${endpoint}/Prod/todos" | grep 'python' | wc -l)  snakes in the collection "

    echo "Delete one snake"
    curl -X DELETE "${endpoint}/Prod/todos/${id}"
    echo

    curl -sX GET "${endpoint}/Prod/todos" | jq
    echo "Items: $(curl -sX GET "${endpoint}/Prod/todos" | jq '.|length')"
    echo "There are $(curl -sX GET "${endpoint}/Prod/todos" | grep 'python' | wc -l)  snakes in the collection "

Verificamos: - La creación de la colección - El listado de todos los
elementos - Obtención de un elemento por su id - Modificación de un
elemento por su id - Borrado de un elemento por su id

La salida del script

``` bash
GET the collection
{
  "statusCode": 200,
  "body": "{\"id\": \"668f2ddf-280b-11ef-8bb6-895c2dcab988\", \"text\": \"Learn Serverless\", \"checked\": false, \"createdAt\": \"1718121490.2184799\", \"updatedAt\": \"1718121490.2184799\"}"
}
Get all items
[
  {
    "checked": false,
    "createdAt": "1718121490.2184799",
    "text": "Learn Serverless",
    "id": "668f2ddf-280b-11ef-8bb6-895c2dcab988",
    "updatedAt": "1718121490.2184799"
  },
  {
    "checked": false,
    "createdAt": "1718118983.04958",
    "text": "Learn Serverless",
    "id": "902b90ab-2805-11ef-bf03-4fc763694e1c",
    "updatedAt": "1718118983.04958"
  },
  {
    "checked": false,
    "createdAt": "1718118710.8484068",
    "text": "Learn Serverless",
    "id": "edecf681-2804-11ef-9d71-4fc763694e1c",
    "updatedAt": "1718118710.8484068"
  },
  {
    "checked": false,
    "createdAt": "1718119233.9508982",
    "text": "Learn Serverless",
    "id": "25b81194-2806-11ef-a9ee-4fc763694e1c",
    "updatedAt": "1718119233.9508982"
  },
  {
    "checked": false,
    "createdAt": "1718121142.9952197",
    "text": "Learn Serverless",
    "id": "97991d2d-280a-11ef-9aa6-895c2dcab988",
    "updatedAt": "1718121142.9952197"
  },
  {
    "checked": false,
    "createdAt": "1718118956.9510274",
    "text": "Learn Serverless",
    "id": "809d3def-2805-11ef-8da7-4fc763694e1c",
    "updatedAt": "1718118956.9510274"
  },
  {
    "checked": false,
    "createdAt": "1718119160.8100808",
    "text": "Learn Serverless",
    "id": "fa1faa49-2805-11ef-9c44-4fc763694e1c",
    "updatedAt": "1718119160.8100808"
  },
  {
    "checked": false,
    "createdAt": "1718118726.228475",
    "text": "Learn Serverless",
    "id": "f717c632-2804-11ef-a837-4fc763694e1c",
    "updatedAt": "1718118726.228475"
  },
  {
    "checked": false,
    "createdAt": "1718118642.7498279",
    "text": "Learn Serverless",
    "id": "c555f1a5-2804-11ef-a4e0-4fc763694e1c",
    "updatedAt": "1718118642.7498279"
  },
  {
    "checked": false,
    "createdAt": "1718121019.2953675",
    "text": "Learn Serverless",
    "id": "4dde040c-280a-11ef-8146-895c2dcab988",
    "updatedAt": "1718121019.2953675"
  },
  {
    "checked": false,
    "createdAt": "1718118365.9501295",
    "text": "Learn Serverless",
    "id": "2059a978-2804-11ef-b653-4fc763694e1c",
    "updatedAt": "1718118365.9501295"
  },
  {
    "checked": false,
    "createdAt": "1718120106.8983665",
    "text": "Learn Serverless",
    "id": "2e094880-2808-11ef-832c-471418803f88",
    "updatedAt": "1718120106.8983665"
  }
]
Items: 12
Get one specific item
{
  "checked": false,
  "createdAt": "1718121490.2184799",
  "text": "Learn Serverless",
  "id": "668f2ddf-280b-11ef-8bb6-895c2dcab988",
  "updatedAt": "1718121490.2184799"
}
Update one to have a snake
{"checked": true, "createdAt": "1718121490.2184799", "text": "Learn python and more", "id": "668f2ddf-280b-11ef-8bb6-895c2dcab988", "updatedAt": 1718121495520}
Items: 12
There are 1  snakes in the collection
Delete one snake

[
  {
    "checked": false,
    "createdAt": "1718118983.04958",
    "text": "Learn Serverless",
    "id": "902b90ab-2805-11ef-bf03-4fc763694e1c",
    "updatedAt": "1718118983.04958"
  },
  {
    "checked": false,
    "createdAt": "1718118710.8484068",
    "text": "Learn Serverless",
    "id": "edecf681-2804-11ef-9d71-4fc763694e1c",
    "updatedAt": "1718118710.8484068"
  },
  {
    "checked": false,
    "createdAt": "1718119233.9508982",
    "text": "Learn Serverless",
    "id": "25b81194-2806-11ef-a9ee-4fc763694e1c",
    "updatedAt": "1718119233.9508982"
  },
  {
    "checked": false,
    "createdAt": "1718121142.9952197",
    "text": "Learn Serverless",
    "id": "97991d2d-280a-11ef-9aa6-895c2dcab988",
    "updatedAt": "1718121142.9952197"
  },
  {
    "checked": false,
    "createdAt": "1718118956.9510274",
    "text": "Learn Serverless",
    "id": "809d3def-2805-11ef-8da7-4fc763694e1c",
    "updatedAt": "1718118956.9510274"
  },
  {
    "checked": false,
    "createdAt": "1718119160.8100808",
    "text": "Learn Serverless",
    "id": "fa1faa49-2805-11ef-9c44-4fc763694e1c",
    "updatedAt": "1718119160.8100808"
  },
  {
    "checked": false,
    "createdAt": "1718118726.228475",
    "text": "Learn Serverless",
    "id": "f717c632-2804-11ef-a837-4fc763694e1c",
    "updatedAt": "1718118726.228475"
  },
  {
    "checked": false,
    "createdAt": "1718118642.7498279",
    "text": "Learn Serverless",
    "id": "c555f1a5-2804-11ef-a4e0-4fc763694e1c",
    "updatedAt": "1718118642.7498279"
  },
  {
    "checked": false,
    "createdAt": "1718121019.2953675",
    "text": "Learn Serverless",
    "id": "4dde040c-280a-11ef-8146-895c2dcab988",
    "updatedAt": "1718121019.2953675"
  },
  {
    "checked": false,
    "createdAt": "1718118365.9501295",
    "text": "Learn Serverless",
    "id": "2059a978-2804-11ef-b653-4fc763694e1c",
    "updatedAt": "1718118365.9501295"
  },
  {
    "checked": false,
    "createdAt": "1718120106.8983665",
    "text": "Learn Serverless",
    "id": "2e094880-2808-11ef-832c-471418803f88",
    "updatedAt": "1718120106.8983665"
  }
]
Items: 11
There are 0  snakes in the collection
```

## Error

Quizás estemos matando moscas a cañonazos. Para conseguir que funcionara
hemos simplificado el método `get_table` haciendo que apunte
directamente a la tabla de dynamo y corrigiendo un typo.

``` python
def get_table(dynamodb=None):
#    if not dynamodb:
#        URL = os.environ['ENDPOINT_OVERRIDE']
#        if URL:
#            print('URL dynamoDB:'+URL)
#            boto3.client = functools.partial(boto3.client, endpoint_url=URL)
#            boto3.resource = functools.partial(boto3.resource,
#                                               endpoint_url=URL)
#        dynamodb = boto3.resource("dynamodb")
#    # fetch todo from the database
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table("staging-TodosDynamoDbTable")
    return table
```

## Diff del método

``` diff
+
 def get_table(dynamodb=None):
-    if not dynamodb:
-        URL = os.environ['ENDPOINT_OVERRIDE']
-        if URL:
-            print('URL dynamoDB:'+URL)
-            boto3.client = functools.partial(boto3.client, endpoint_url=URL)
-            boto3.resource = functools.partial(boto3.resource,
-                                               endpoint_url=URL)
-        dynamodb = boto3.resource("dynamodb-dbdbdb")
-    # fetch todo from the database
-    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])
+#    if not dynamodb:
+#        URL = os.environ['ENDPOINT_OVERRIDE']
+#        if URL:
+#            print('URL dynamoDB:'+URL)
+#            boto3.client = functools.partial(boto3.client, endpoint_url=URL)
+#            boto3.resource = functools.partial(boto3.resource,
+#                                               endpoint_url=URL)
+#        dynamodb = boto3.resource("dynamodb")
+#    # fetch todo from the database
+    dynamodb = boto3.resource("dynamodb")
+    table = dynamodb.Table("staging-TodosDynamoDbTable")
```
