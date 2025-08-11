#!/usr/bin/env bash
set -euo pipefail

base_url="http://localhost:8000"
key_header="apikey: DEMO-API-KEY"

echo "[1/3] Health check (Admin API)"
curl -fsS http://localhost:8001/ | jq '.version' || true

echo "[2/3] Echo GET with key"
curl -fsS -H "$key_header" "$base_url/echo" | jq '.headers["x-forwarded-host"], .url' || true

echo "[3/3] Rate limit burst (expect 429 eventually)"
rc=0
for i in {1..65}; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -H "$key_header" "$base_url/echo") || rc=$?
  echo "$i -> $code"
  sleep 0.2
done
exit $rc