#!/bin/bash

# If permissions not enabled to run the file, try:
# 'chmod +x install_packages.sh'

# Read the package list from the file
PACKAGE_FILE="packages"

# Update package list
sudo apt-get update

# Install each package
while IFS= read -r line; do
    package=$(echo $line | awk '{print $1}')
    sudo apt-get install -y $package
done < "$PACKAGE_FILE"
