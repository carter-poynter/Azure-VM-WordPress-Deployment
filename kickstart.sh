#!/bin/bash

# Update the system
sudo apt update
sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
sudo apt install -y docker-compose

# Create a directory for the WordPress project
mkdir wordpress
cd wordpress

# Create the docker-compose.yml file
cat <<EOF > docker-compose.yml
version: '3'

services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_mysql_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: your_wordpress_db_password

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - 80:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: your_wordpress_db_password
      WORDPRESS_DB_NAME: wordpress

volumes:
  db_data:
EOF

# Start the WordPress containers using Docker Compose
sudo docker-compose up -d