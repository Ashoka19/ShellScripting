#!/bin/bash

#This script will remove a log or make it tar and it's also ask you for log path and days and also confirm you again u want delete a log or not...!!!

echo "Please enter Log Path"
read "LogPath"

echo "Please enter how much days log you want to delete"
read "Days"

find $LogPath -mtime -$Days -print

echo "are you sure you want to delete a log"
read "Confirmation"

if [ $Confirmation = yes ]
then

  find $LogPath -type f -iname '*.log' -mtime -$Days -exec rm -f '{}' \+

elif [ $Confirmation = no ]
then
  find $LogPath -type f -iname '*.log' -mtime -$Days -exec tar -czvf log.tar.gz '{}' \+
else
  echo "Confirmation is wronge please enter yes or no"
fi
