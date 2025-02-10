#!/bin/bash

# The first find command in each group is for printing the results to a hidden text file
# in the current working directory
# maxdepth set to 1 in case you have any folders in your downloads 
# that you'd rather not disturb
# set -x # uncomment this to turn on debugging
#a file to store all the results
now=$(date +"%m_%d_%Y_%H_%M_%S")
filename="sortResults_$now.txt"

# Ensure target directories exist
if [ ! -e "$HOME/.sortResults/" ]; then
    echo "no sortResults folder making one now..."
    mkdir .sortResults/
fi

if [ ! -d "$HOME/DiskImages/" ]; then
    echo "$HOME/DiskImages does not exist, creating it now..."
    mkdir -p "$HOME/DiskImages/"
fi

if [ ! -d "$HOME/Pictures/SVGs/" ]; then
    echo "$HOME/Pictures/SVGs/ does not exist, creating it now..."
    mkdir -p "$HOME/Pictures/SVGs/"
fi

if [ ! -d "$HOME/Pictures/ToBeSorted/" ]; then
    echo "$HOME/Pictures/ToBeSorted/ does not exist, creating it now..."
    mkdir -p "$HOME/Pictures/ToBeSorted/"
fi

if [ ! -d "$HOME/Archives/" ]; then
    echo "$HOME/Archives/ does not exist, creating it now..."
    mkdir -p "$HOME/Archives/"
fi

if [ ! -d "$HOME/Documents/" ]; then
    echo "$HOME/Documents/ does not exist, creating it now..."
    mkdir -p "$HOME/Documents/"
fi

if [ ! -d "$HOME/Videos/" ]; then
    echo "$HOME/Videos/ does not exist, creating it now..."
    mkdir -p "$HOME/Videos/"
fi

if [ ! -d "$HOME/Music/SongsToSort/" ]; then
    echo "$HOME/Music/SongsToSort/ does not exist, creating it now..."
    mkdir -p "$HOME/Music/SongsToSort/"
fi

if [ ! -d "$HOME/.font_backups/" ]; then
    echo "$HOME/.font_backups/ does not exist, creating it now..."
    mkdir -p "$HOME/.font_backups/"
fi

dirName="$HOME/.sortResults"
echo "$dirName is the directory"
# Move Videos
#find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" \) -exec echo "Found: {}" \;
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" \) -exec echo mv {} $HOME/Videos/ \; > $dirName/$filename
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" \) -exec mv {} $HOME/Videos/ \;
# Move Music
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.aac" -o -iname "*.aiff" -o -iname "*.dsd" -o -iname "*.pcm" \) -exec echo mv {} $HOME/Music/SongsToSort/ \; > $dirName/$filename
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.aac" -o -iname "*.aiff" -o -iname "*.dsd" -o -iname "*.pcm" \) -exec mv {} $HOME/Music/SongsToSort/ \;
# Move ISO files
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.iso" \) -exec echo mv {} $HOME/DiskImages/ \; >> $dirName/$filename 
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.iso" \) -exec mv {} $HOME/DiskImages/ \; 
# Move Pictures
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.gif" -o -iname "*.webp" \) -exec echo mv {} $HOME/Pictures/ToBeSorted/ \; >> $dirName/$filename 
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.gif" -o -iname "*.webp" \) -exec mv {} $HOME/Pictures/ToBeSorted/ \;
# move SVGs
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.svg" \) -exec echo mv {} $HOME/Pictures/SVGs/ \; >> $dirName/$filename 
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.svg" \) -exec mv {} $HOME/Pictures/SVGs/ \; 
# Move archives
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.zip" -o -iname "*.7z" -o -iname "*.tar" -o -iname "*.tar.*" \) -exec echo mv {} $HOME/Archives/ \; >> $dirName/$filename
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.zip" -o -iname "*.7z" -o -iname "*.tar" -o -iname "*.tar.*" \) -exec mv {} $HOME/Archives/ \;
# move documents
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.txt" -o -iname "*.pdf" -o -iname "*.doc" -o -iname "*.ppt" -o -iname "*.docx" -o -iname "*.pptx" \) -exec echo mv {} $HOME/Documents/ \; >> $dirName/$filename
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.txt" -o -iname "*.pdf" -o -iname "*.doc" -o -iname "*.ppt" -o -iname "*.docx" -o -iname "*.pptx" \) -exec mv {} $HOME/Documents/ \;
#move fonts
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" \) -exec echo mv {} $HOME/.font_backups/ \; >> $dirName/$filename
find $HOME/Downloads/ -maxdepth 1 -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" \) -exec mv {} $HOME/.font_backups/ \;
 
echo "operation complete!"
echo "please check the file inside" 
echo "$dirName/$filename for your results"