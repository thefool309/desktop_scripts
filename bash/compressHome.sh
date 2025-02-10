#!/bin/bash

### THIS SCRIPT IS UNTESTED AND BROKE MY HOME DIRECTORY
### USE AT YOUR OWN PERIL
### DON'T DO WHAT VELMA DOES AND sudo rm -rf $HOME
set -x
#prep stagename
now=$(date +"%m_%d_%Y_%H_%M")

stageName="HomeBackup_$now"
#prep destination 
destination="/home/$USER-backups"

if [ ! -e "$destination" ]; then
    sudo mkdir -p "$destination"
fi 

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

if [ -d "$HOME/Documents/" ]; then
    cp -R "$HOME/Documents/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Documents/ skipping..."
fi

if [ -d "$HOME/.font_backups/" ]; then
    cp -R "$HOME/.font_backups/" "$HOME/$stageName/"
else
    echo "No directory $HOME/.font_backups/ skipping..."
fi

if [ -d "$HOME/Music/" ]; then
    cp -R "$HOME/Music/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Music/ skipping..."
fi

if [ -d "$HOME/Pictures/" ]; then
    cp -R "$HOME/Pictures/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Pictures/ skipping..."
fi

if [ -d "$HOME/Videos/" ]; then
    cp -R "$HOME/Videos/" "$HOME/$stageName/"
else
    echo "No directory $HOME/Videos/ skipping..."
fi

if [ -e "$HOME/.bashrc" ]; then
    cp -R "$HOME/.bashrc" "$HOME/$stageName/"
else 
    echo "No $HOME/.bashrc skipping..."
fi

if [ -e "$HOME/.gitconfig/" ]; then
    cp -R "$HOME/.gitconfig/" "$HOME/$stageName/"
else
    echo "No $HOME/.gitconfig/ skipping..."
fi

if [ -e "$HOME/.nv/" ]; then
    cp -R "$HOME/.nv/" "$HOME/$stageName/"
else
    echo "No $HOME/.nv/ skipping..."
fi

if [ -e "$HOME/.nv/" ]; then
    cp -R "$HOME/.nvidia-settings-rc" "$HOME/$stageName/"
else
    echo "No $HOME/.nv/ skipping..."
fi

# compress stage into archive
echo "beginning compression"

tar -czf "$HOME/$stageName.tar.gz" "$HOME/$stageName/"
# clean up by deleting stage
rm -rf "$HOME/${stageName:?}/"
# now move backups to destination
sudo mv "$HOME/$stageName.tar.gz" "$destination"
