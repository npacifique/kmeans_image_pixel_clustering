#!/bin/bash
app="kmeans_image_extractor.api"
docker build -t ${app} .
docker run -d -p 8011:8011 \
  --name=${app} \
  -v $PWD:/app ${app}