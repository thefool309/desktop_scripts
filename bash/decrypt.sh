#! /usr/bin/env bash

filename=${1:-}

set -euo pipefail

shutdown(){
  echo "Error: $1" >&2
  exit 1
}


# check if filename is empty
if [ -z "$filename" ]; then
  shutdown "Usage: .decrypt_backup.sh <filename>"
fi
# check if file exists
if [ ! -f "$filename" ]; then
  shutdown "File not found: $filename"
fi

tmp_tar=$(mktemp)

trap 'rm -f "${tmp_tar:-}"' EXIT

# if filename isn't empty and file exists
gpg --batch --yes -d -o "$tmp_tar" "$filename"

tar -xvf "$tmp_tar"

echo "backup decrypted successfully!"

