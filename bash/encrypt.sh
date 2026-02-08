#! /usr/bin/env bash

#! REMAINS UNTESTED !#

INPUT_DIR=${1:-}

KEY_ID=${2:-}


#! /usr/bin/env bash

set -euo pipefail

shutdown(){
  echo "Error: $1" >&2
  exit 1
}


# check if filename is empty
if [ -z "$INPUT_DIR" ]; then
  shutdown "Usage: .encrypt.sh <INPUT_DIR> <KEY_ID>"
fi
# check if file exists
if [ ! -d "$INPUT_DIR" ]; then
  shutdown "Directory not found: $INPUT_DIR"
fi
# check if KEY_ID exists
if [ -z "$KEY_ID" ]; then
  shutdown "Usage: .encrypt.sh <INPUT_DIR> <KEY_ID>"
fi

tmp_tar=$(mktemp)

# ensure we are deleting the tmp tar ball on exit
trap 'rm -f "${tmp_tar:-}"' EXIT

# if filename isn't empty and file exists
tar -czvf "$tmp_tar" "$INPUT_DIR"

gpg -e -a --cipher-algo AES256 -r "$KEY_ID" -o "$INPUT_DIR".tar.asc "$tmp_tar"

echo "backup encrypted successfully!"

