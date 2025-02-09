#!/bin/bash

### THIS SCRIPT IS UNTESTED AND BROKE MY HOME DIRECTORY
### USE AT YOUR OWN PERIL
### DON'T DO WHAT VELMA DOES AND sudo rm -rf $HOME
set -x
#prep filename
now=$(date +"%m_%d_%Y_%H_%M")

stageName="HomeBackup_$now"


# create the stage
echo "creating stage $HOME/$stageName/"
mkdir -p "$HOME/$stageName/"
# copy all things you wish to save to stage
echo "copying files..."
if [ -d "$HOME/Archives/" ]; then
    cp -R "$HOME/Archives/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Archives/ skipping..."
fi
if [ -d "$HOME/Downloads/" ]; then
    cp -R "$HOME/Downloads/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Downloads/ skipping..."
fi

cp -R "$HOME/Documents/" "$HOME/$stageName/"
cp -R "$HOME/.font_backups/" "$HOME/$stageName/"
cp -R "$HOME/Music/" "$HOME/$stageName/"
cp -R "$HOME/Pictures/" "$HOME/$stageName/"
cp -R "$HOME/Videos/" "$HOME/$stageName/"
cp -R "$HOME/.bash_profile" "$HOME/$stageName/"
cp -R "$HOME/.gitconfig/" "$HOME/$stageName/"
cp -R "$HOME/.nv/" "$HOME/$stageName/"
cp -R "$HOME/.nvidia-settings-rc" "$HOME/$stageName/"


# compress stage into archive
echo "beginning compression"

echo tar -czvf "$HOME/$stageName.tar.gz" "$HOME/$stageName/"
# clean up by deleting stage
# rm -ri $HOME/$stageName/
