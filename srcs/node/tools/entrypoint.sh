#!/bin/sh

echo "Installing dependencies..."
rm -rf node_modules
mkdir node_modules
npm ci || npm install

exec "$@"