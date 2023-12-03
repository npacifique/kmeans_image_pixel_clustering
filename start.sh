#!/bin/bash

docker_image_tag="kmeans_image_extractor:latest"
container="kmeans_extractor.api"

# Check if the Docker image already exists
if docker image inspect "${docker_image_tag}" &> /dev/null; then
    echo "Removing existing Docker image: ${docker_image_tag}"
    docker container rm "/${container} -f"
    docker image rm "${docker_image_tag} -f"
fi

# Build the Docker image
docker build -t "${docker_image_tag}" .

# Run the Docker container
docker run -d -p 8011:8011 \
  --name="${container}" \
  -v "$PWD:/app" "${docker_image_tag}"