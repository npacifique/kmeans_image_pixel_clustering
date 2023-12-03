#!/bin/bash

app="kmeans_image_extractor.api"
docker_image_tag="${app}"

# Check if the Docker image already exists
if docker image inspect "${docker_image_tag}" &> /dev/null; then
    echo "Removing existing Docker image: ${docker_image_tag}"
    docker image rm "${docker_image_tag}"
fi

# Build the Docker image
docker build -t "${app}" .

# Run the Docker container
docker run -d -p 8011:8011 \
  --name="${app}" \
  -v "$PWD:/app" "${app}"