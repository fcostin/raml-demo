FROM node:8.15.0-alpine

RUN apk add --no-cache git

RUN mkdir /tmp/work
WORKDIR /tmp/work

RUN git clone https://github.com/mulesoft/oas-raml-converter

WORKDIR /tmp/work/oas-raml-converter
RUN npm install
RUN npm run build


COPY fruitmarket-swagger.yaml /tmp/work/fruitmarket-swagger.yaml
RUN /usr/bin/env node --harmony ./lib/bin/converter.js --from OAS20 --to RAML /tmp/work/fruitmarket-swagger.yaml > /tmp/work/fruitmarket.raml
