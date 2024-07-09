#!/bin/bash

#set -e  # Exit immediately if a command exits with a non-zero status.

# Function to create a network if it doesn't already exist
create_network() {
  network_name=$1
  if ! docker network ls --format '{{.Name}}' | grep -w $network_name > /dev/null; then
    docker network create $network_name
    echo "Network '$network_name' created."
  else
    echo "Network '$network_name' already exists."
  fi
}

# Function to create a volume if it doesn't already exist
create_volume() {
  volume_name=$1
  if ! docker volume ls --format '{{.Name}}' | grep -w $volume_name > /dev/null; then
    docker volume create $volume_name
    echo "Volume '$volume_name' created."
  else
    echo "Volume '$volume_name' already exists."
  fi
}

# Create Docker networks
create_network frontend_network
create_network backend_network

# Create Docker volumes
create_volume static
create_volume frontend
create_volume mysql-data

# Run the database service
docker run -d \
  --name db \
  --network backend_network \
  --health-cmd='mysqladmin ping -h db' \
  --health-interval=20s \
  --health-timeout=20s \
  --health-retries=10 \
  -v mysql-data:/var/lib/mysql \
  -v $(pwd)/mysql_init:/docker-entrypoint-initdb.d \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
  -e MYSQL_DATABASE=ordering_system \
  -e MYSQL_USER=admin \
  -e MYSQL_PASSWORD=admin \
  -e DATABASE_URL=mysql://admin:admin@db/ordering_system \
  -e DJANGO_SUPERUSER_USERNAME=admin \
  -e DJANGO_SUPERUSER_EMAIL=admin@example.com \
  mysql:8.0
echo "Database container 'db' is running."

# Build the backend image
docker build -t backend-image ./backend
echo "Backend image built."

# Run the backend service with entrypoint.sh
docker run -d \
  --name backend \
  --network backend_network \
  --env-file .env \
  --link db:db \
  backend-image \
echo "Backend container 'backend' is running."

# Build the frontend image
docker build -t frontend-image ./frontend
echo "Frontend image built."

# Run the frontend service
docker run -d \
  --name frontend \
  --network frontend_network \
  -v frontend:/app/build \
  frontend-image
echo "Frontend container 'frontend' is running."

# Build the nginx image
docker build -t nginx-image ./nginx
echo "nginx image built."

# Create the nginx container
nginx_container=$(docker create \
  --name nginx \
  --network frontend_network \
  -v static:/static \
  -v frontend:/var/www/frontend \
  -p 80:80 \
  nginx-image)
echo "nginx container created with ID $nginx_container."

# Connect the nginx container to the backend network
docker network connect backend_network $nginx_container
echo "nginx container connected to backend_network."

# Start the nginx container
docker start $nginx_container
echo "nginx container 'nginx' is running."
