#!/bin/sh

if [ "$(id -u)" != "0" ]; then
  echo "fixperms must be run with sudo" 1>&2
  exit 1
fi

CURDIR=`pwd`
pwd | grep '^/srv' > /dev/null

if [ $? -eq 0 ]
then
  chown www-data:www-data $CURDIR/* $CURDIR/.[a-zA-Z0-9_]* -R 2>&1 | grep -v "No such"
  chmod g+rw $CURDIR/* $CURDIR/.[a-zA-Z0-9_]* -R 2>&1 | grep -v "No such"
  exit 0
else
  echo "Oops! You just tried to run fixperms in $CURDIR, which is not a subdirectory of /srv You're fired!"
  exit 1
fi
