#!/bin/bash

set -x
nameOfDir="$HOME/Documents/.$USER-diary/"
if [ -d "$nameOfDir" ]; then
    echo "$nameOfDir directory exists..."
else
    echo "Diary Directory not found. Creating at $nameOfDir" 
    mkdir -p "$nameOfDir"
fi
now=$(date +"%m_%d_%y")
filename=DiaryEntry_"$now".md

if [ -f "$nameOfDir""$filename" ]; then
    timestamp=$(date +"%H%M%S") # Adds hours, minutes, seconds
    filename="DiaryEntry_${now}_${timestamp}.md"
fi

echo "$filename"

touch "$nameOfDir""$filename"

chmod 600 "$nameOfDir""$filename"

# Add a header
echo "# Diary Entry - $(date +"%A, %B %d, %Y")" >> "$nameOfDir""$filename"
echo "" >> "$nameOfDir""$filename"

if ! command -v codium &> /dev/null; then
    echo "VSCodium not found. Opening with nano instead."
    nano "$nameOfDir""$filename"
else
    codium "$nameOfDir""$filename"
fi