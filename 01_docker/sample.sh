#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Set up variables
IMAGE_NAME="static-website"
CONTAINER_NAME="static-website-container"
PORT=7777

# Step 1: Create the project directory and navigate to it
mkdir -p docker-static-site && cd docker-static-site

# Step 2: Create the index.html file
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Dockerized Website!</title>
</head>
<body>
    <h1>Hello from Docker!</h1>
    <p>This is a static website running in a Docker container.</p>
</body>
</html>
EOF

# Step 3: Create the Dockerfile
cat <<EOF > Dockerfile
# Use an Nginx base image
FROM nginx:latest

# Copy the static website files to the container
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
EOF

# Step 4: Ensure Docker is running on Fedora
if ! systemctl is-active --quiet docker
then
    echo "Docker service is not running. Starting Docker..."
    sudo systemctl start docker
    if ! systemctl is-active --quiet docker
    then
        echo "Failed to start Docker. Please check your installation."
        exit 1
    fi
fi

# Step 5: Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME .

# Step 6: Run the Docker container
echo "Running the Docker container..."
docker run -d --name $CONTAINER_NAME -p $PORT:80 $IMAGE_NAME

# Display the success message with URL
echo "Your static website is now running at http://localhost:$PORT"

# Cleanup function to stop and remove the container (optional)
cleanup() {
    echo "Stopping and removing the Docker container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    docker rmi $IMAGE_NAME
    rm -rf docker-static-site
    echo "Cleanup completed."
}

# Provide the user with an option to clean up
read -p "Do you want to clean up the resources after testing? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    cleanup
fi
