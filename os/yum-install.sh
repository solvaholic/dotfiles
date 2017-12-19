#!/bin/sh

set -e

# Update packages
echo "> yum update -y"
sudo yum update -y

# TODO: Install the default package list...

echo "Install the default package list..."
sudo yum groupinstall 'Development Tools'
sudo yum install curl file zsh -y
