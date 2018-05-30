#!/bin/sh
# From https://www.dropbox.com/install-linux and
# https://www.jamescoyle.net/how-to/1147-setup-headless-dropbox-sync-client

cd ~ && wget https://www.dropbox.com/download?dl=packages/dropbox.py -O dropbox.py
chmod 700 dropbox.py
./dropbox.py start -i

mkdir -p ~/.config/autostart
cp dropboxd.desktop ~/.config/autostart

printf "\n[--] Dropbox installed. Use ~/dropbox.py to operate:\n\n"
./dropbox.py --help
