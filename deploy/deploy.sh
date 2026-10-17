#!/usr/bin/env bash
# Build the offline version and upload it to the server.
# Usage:   ./deploy/deploy.sh user@your-server [/var/www/buzz]
# One-time on the server first:  sudo mkdir -p /var/www/buzz && sudo chown "$USER" /var/www/buzz
set -euo pipefail

HOST="${1:?usage: deploy.sh user@server [remote_dir]}"
DIR="${2:-/var/www/buzz}"
PKG="$(cd "$(dirname "$0")/.." && pwd)"

python3 "$PKG/build.py"
rsync -avz --delete "$PKG/docs/" "$HOST:$DIR/"
echo "Uploaded to $HOST:$DIR. Open the site on the phone once with internet to get the update."
