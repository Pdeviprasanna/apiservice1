#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../infra"
echo "Starting minimal Kong + hello-service stack..."
docker compose up -d
sleep 5
echo "Try: curl -i http://localhost:8000/hello"