#!/bin/bash
app="kmeans_image_extractor.api"
docker build -t ${app} .
docker run -d -p 80111:80 \
  --name=${app} \
  -v $PWD:/app ${app}