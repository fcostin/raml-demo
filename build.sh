#!/bin/bash
docker build -f Dockerfile -t oas-raml-converter:dev .

TEMP_CONTAINER_ID=$(docker create oas-raml-converter:dev)
function cleanup_container {
    docker rm "$TEMP_CONTAINER_ID"
}

docker cp "$TEMP_CONTAINER_ID":/tmp/work/fruitmarket.raml fruitmarket.raml


