#!/bin/bash
docker build -f go-raml.Dockerfile -t go-raml:dev .

TEMP_CONTAINER_ID=$(docker create go-raml:dev)
function cleanup_container {
    docker rm "$TEMP_CONTAINER_ID"
}

docker cp "$TEMP_CONTAINER_ID":/go/src/fruit.example.com/fruitmarket fruitmarket


