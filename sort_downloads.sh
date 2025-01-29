#!/bin/bash

# The first find command in each group is for printing the results to a hidden text file
# in the current working directory
# maxdepth set to 1 in case you have any folders in your downloads 
# that you'd rather not disturb

#a file to store all the results
now=$(date +"%m_%d_%Y_%H_%M_%S")
filename="sortResults_$now.txt"

# Move Videos
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" \) -exec echo mv {} ~/DiskImages/ \; > ./.$filename
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" \) -exec mv {} ~/DiskImages/ \;
# Move ISO files
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.iso" \) -exec echo mv {} ~/DiskImages/ \; >> ./.$filename
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.iso" \) -exec mv {} ~/DiskImages/ \; 
# Move Pictures
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.gif" -o -iname "*.webp" \) -exec echo mv {} ~/Pictures/ToBeSorted/ \; >> ./.$filename 
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.gif" -o -iname "*.webp" \) -exec mv {} ~/Pictures/ToBeSorted/ \;
# Move archives
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.zip" -o -iname "*.7z" -o -iname "*.tar" -o -iname "*.tar.*" \) -exec echo mv {} ~/Archives/ \; >> ./.$filename
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.zip" -o -iname "*.7z" -o -iname "*.tar" -o -iname "*.tar.*" \) -exec mv {} ~/Archives/ \;
# move documents
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.txt" -o -iname "*.pdf" -o -iname "*.doc" -o -iname "*.ppt" -o -iname "*.docx" -o -iname "*.pptx" \) -exec echo mv {} ~/Documents/ \; >> ./.$filename
find ~/Downloads/ -maxdepth 1 -type f \( -iname "*.txt" -o -iname "*.pdf" -o -iname "*.doc" -o -iname "*.ppt" -o -iname "*.docx" -o -iname "*.pptx" \) -exec mv {} ~/Documents/ \;

echo "operation complete!"
echo "please check the hidden file" 
echo ".$filename for your results"