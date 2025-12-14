#!/usr/bin/env bash
# Simple helper to serve the demo on port 8080
set -e
cd "$(dirname "$0")"
echo "Serving site on http://localhost:8080 — press Ctrl-C to stop"
python3 -m http.server 8080
