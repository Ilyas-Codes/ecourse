# Use a Node.js base image
FROM node:20.11.1-buster

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Ensure entrypoint script is executable
RUN chmod +x /app/entrypoint.sh

# Install unzip utility
RUN apt-get update && apt-get install -y unzip

# Download PocketBase without extracting
ARG PB_VERSION=0.22.20
RUN mkdir -p /app/pb \
    && echo "Downloading PocketBase version ${PB_VERSION}" \
    && wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip -O /tmp/pb.zip \
    && ls -la /tmp

# Switch to the UI directory
WORKDIR /app/ui

# Update environment variable and build the frontend
RUN sed -i 's/^VITE_PROD_PB_URL=.*/VITE_PROD_PB_URL=http:\/\/127.0.0.1:8090/' .env \
    && npm install \
    && npm run build

# Expose the PocketBase port
EXPOSE 8090

# Use the script to start the application
ENTRYPOINT ["/app/entrypoint.sh"]
