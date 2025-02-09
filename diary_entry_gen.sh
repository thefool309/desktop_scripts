#!/bin/bash

# set -x
nameOfDir="$HOME/$USER-Diary/"
if [ -d "$nameOfDir" ]; then
    echo "$nameOfDir directory exists..."
else
    echo "Diary Directory not found. Creating at $nameOfDir" 
    mkdir -p "$nameOfDir"
fi
now=$(date +"%m_%d_%y")
filename=DiaryEntry_"$now".md
echo "$filename"

touch "$nameOfDir""$filename"

chmod 600 "$nameOfDir""$filename"

codium "$nameOfDir""$filename"