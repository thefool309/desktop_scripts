#!/bin/bash

# Check if a directory was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"
# remove trailing slash if present
DIR="${DIR%/}"
# Does this directory exist?
if [ ! -d "$DIR" ]; then
    echo "Directory not found: $DIR"
    exit 1
fi

counter=1

# Loop through every image file in the provided directory
for IMAGE in "$DIR"/*.{jpg,jpeg,png,tiff}; do
    # Check if the file exists in case there are no matching files
    if [ -f "$IMAGE" ]; then
        # Get the file extension
        EXT="${IMAGE##*.}"

        # Generate a new generic name
        NEW_NAME="$DIR/image_$counter.$EXT"

        echo "Stripping EXIF from $IMAGE"
        exiftool -gps:all= -gpslatitude="$LATITUDE" -gpslongitude="$LONGITUDE" -gpsdatetime="$DATETIME" -iptc:all= -xmp:all= -DateTimeOriginal= -CreateDate= -ModifyDate= -overwrite_original "$IMAGE"

        mv "$IMAGE" "$NEW_NAME"
        echo "Renamed $IMAGE to $NEW_NAME"

        ((counter++))
    fi
done

echo "EXIF data has been stripped from all images in $DIR"
echo "All files in $DIR have been renamed."
