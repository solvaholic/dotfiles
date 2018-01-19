#!/bin/sh

set -e

# TODO: Check to make sure we were run from script/install.

# Update packages
echo "> yum update -y"
sudo yum update -y

# TODO: Install the default package list...

echo "Install the default package list..."
sudo yum groupinstall 'Development Tools'
sudo yum install curl file zsh -y
