#!/bin/bash

# This assumes there is only one user on the machine (remove /'whoami' otherwise)
# and that you used the same username on both installs (modify dest. of rsync otherwise).

# Define the config directory
CONFIG_DIR="/home/$(whoami)/config"

# Restore home directory
rsync --progress "$CONFIG_DIR/" /home/$(whoami)

# Restore repository keys and sources list
sudo apt-key add "$CONFIG_DIR/Repo.keys"
sudo cp -R "$CONFIG_DIR/sources.list*" /etc/apt/

# Update package list and install packages
sudo apt-get update
sudo apt-get install dselect
sudo dpkg --set-selections < "$CONFIG_DIR/Package.list"
sudo dselect

echo "Reinstallation completed from $CONFIG_DIR"