#!/bin/bash

# This assumes there is only one user on the machine (remove /'whoami' otherwise)
# and that you used the same username on both installs (modify dest. of rsync otherwise).

# Create the config directory if it doesn't exist
CONFIG_DIR="/home/$(whoami)/config"
mkdir -p "$CONFIG_DIR"

# Backup package selections
dpkg --get-selections > "$CONFIG_DIR/Package.list"

# Backup sources list and repository keys
sudo cp -R /etc/apt/sources.list* "$CONFIG_DIR/"
sudo apt-key exportall > "$CONFIG_DIR/Repo.keys"

# Backup home directory
rsync --progress /home/$(whoami) "$CONFIG_DIR/"
echo "Backup completed and saved to $CONFIG_DIR"

##  Reinstall now

rsync --progress / /home/`whoami`
sudo apt-key add ~/Repo.keys
sudo cp -R ~/sources.list* /etc/apt/
sudo apt-get update
sudo apt-get install dselect
sudo dpkg --set-selections < ~/Package.list
sudo dselect