#!/bin/bash

# Update the system
apt update
apt upgrade -y

# Install Docker
apt install -y docker.io

# Start Docker service
systemctl start docker
systemctl enable docker

# Pull the WordPress image from Docker Hub
docker pull wordpress

# Run the WordPress container
docker run -d -p 80:80 --name mywordpress -e WORDPRESS_DB_HOST=db_host -e WORDPRESS_DB_USER=db_user -e WORDPRESS_DB_PASSWORD=db_password -e WORDPRESS_DB_NAME=db_name wordpress

# Cleanup
apt autoremove -y