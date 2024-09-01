#!/bin/bash

# Extract PocketBase if not already extracted
if [ ! -f "/app/pb/pocketbase" ]; then
  echo "Extracting PocketBase PROD..."
  unzip /tmp/pb.zip -d /app/pb
fi

# Check if PocketBase is executable
if [ -f "/app/pb/pocketbase" ] && [ -x "/app/pb/pocketbase" ]; then
  echo "Starting PocketBase..."
  /app/pb/pocketbase serve --http=0.0.0.0:8090
  mv /app/ui/dist/* /app/pb/pb_public
else
  echo "Error: PocketBase not found or not executable"
  ls -la /app/pb
  exit 1
fi
