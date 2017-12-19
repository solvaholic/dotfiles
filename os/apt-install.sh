#!/bin/sh

set -e

# Update packages
echo "> apt update"
sudo apt update
echo "> apt upgrade -y"
sudo apt upgrade -y

# TODO: Install the default package list...

echo "Install the default package list..."
sudo apt install build-essential curl file zsh -y
