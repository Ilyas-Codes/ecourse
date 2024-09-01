#!/bin/bash

# Extract PocketBase if not already extracted
if [ ! -f "/app/pb/pocketbase" ]; then
  echo "Extracting PocketBase DEV..."
  unzip /tmp/pb.zip -d /app/pb
fi

# Start PocketBase in the background
if [ -f "/app/pb/pocketbase" ] && [ -x "/app/pb/pocketbase" ]; then
  echo "Starting PocketBase DEV..."
  /app/pb/pocketbase serve --http=0.0.0.0:8090 > /proc/1/fd/1 2>/proc/1/fd/2 &
  PB_PID=$!
  echo "PocketBase started with PID $PB_PID"
else
  echo "Error: PocketBase not found or not executable"
  ls -la /app/pb
  exit 1
fi

# Start the Vite development server
echo "Starting Vite development server..."
cd /app/ui
npm run dev -- --host 0.0.0.0 > /proc/1/fd/1 2>/proc/1/fd/2 &

VITE_PID=$!
echo "Vite started with PID $VITE_PID"

# Wait for both processes to finish
wait $PB_PID
wait $VITE_PID
