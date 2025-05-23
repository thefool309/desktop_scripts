#!/bin/bash

# Check if a directory was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Provided directory
DIR="$1"

# Does this directory exist?
if [ ! -d "$DIR" ]; then
    echo "Directory not found: $DIR"
    exit 1
fi

# Loop through ever image file in the provided dir
for IMAGE in "$DIR"/*.{jpg,jpeg,png,tiff}; do
    # Check if the file exists in case there are no matching files
    if [ -f "$IMAGE" ]; then
        echo "Stripping EXIF from $IMAGE"
        exiftool -gps:all= -iptc:all= -xmp:all= -DateTimeOriginal= -CreateDate= -ModifyDate= -overwrite_original "$IMAGE"
    fi
done

echo "EXIF data has been stripped from all images in $DIR"
