#!/usr/bin/env bash
#/ Usage: burn_disk.sh
#/
#/ This script reads and writes aggressively to a file in your
#/ current working directory.
#/
#/ OPTIONS:
#/   -h | --help                      Show this message.
#/
#
# - - - -
# I need something to sit and read and write a file. It has to
# write non-zero data. Random is OK; Sequential is unnecessary.
#
# This has been useful generating load on a LUN, and keeping an
# attached disk busy.
#
# - - - -
# References:
# http://stackoverflow.com/questions/3598622/is-there-a-command-to-write-random-garbage-bytes-into-a-file
# http://linux.die.net/man/1/dd
# http://www.tldp.org/LDP/abs/html/randomvar.html
#
# - - - -

# Exit if any command fails ...
set -e

# Handle requests for usage instructions ...
if [ "$1" = "--help" -o "$1" = "-h" ]; then
  grep '^#/' <"$0" | cut -c 4-
  exit 2
fi

# Warn what's about to happen ...
cat <<eom


WARNING: You're about to read and write, aggressively, to your
current working directory:

$( pwd )

Press CTRL-C now if you're not certain you want this.

... You have five seconds to decide ...


eom

sleep 5

# Set some values ...
ifile="/dev/urandom"   # Input File
ofile="./sadfile"  # Output File
bsize="4k"   # What block size to use?
fsize="51200"   # How many blocks big is the file?
wrmax="1000"   # What's the longest write, in blocks?
percwrite="50"   # What % writes?

# Fill the file.
echo "Creating $ofile with $fsize $bsize blocks from $ifile ..."
dd if="$ifile" of="$ofile" bs=$bsize count=$fsize &> /dev/null

# Write randomly to the file ...
echo "Now we'll read and write $ofile until .. idk, how *do* you exit this?"

while true; do
  readorwrite=$(($RANDOM % 100))
  wrlen=$(($RANDOM % $wrmax))
  wroffset=$(($RANDOM % ( $fsize - $wrmax )))
  if [ $readorwrite -gt $percwrite ]; then
    echo "Writing $wrlen $bsize blocks to $ofile at offset $wroffset ..."
    dd if="$ifile" of="$ofile" bs=$bsize count=$wrlen seek=$wroffset &> /dev/null
  else
    echo "Reading $wrlen $bsize blocks from $ofile at offset $wroffset ..."
    dd if="$ofile" of=/dev/null bs=$bsize count=$wrlen seek=$wroffset &> /dev/null
  fi
done
