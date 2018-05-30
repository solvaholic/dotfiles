#!/bin/sh

# Do we have wget? and can we sudo?

# Download and install or update Calibre.
sudo chown "$( whoami )" /opt && sudo -k chmod 775 /opt
wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh
mkdir -p "$HOME/bin"
ln -s /opt/calibre/calibre "$HOME/bin"
