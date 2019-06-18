#!/bin/bash

#This script will remove a log or make it tar and it's also ask you for log path and days and also confirm you again u want delete a log or not...!!!

echo "Please enter Log Path"
read "LogPath"
####################
if [ -e $LogPath ]
then
   echo "Path exist u will going to ask for days"
else
   echo "Please enter a write path"
   exit
fi
sleep 2s
########################
echo "Please enter how much days log you want to delete"
read "Days"
######################
if [ $Days -gt 100 ] 
then
   echo "Days invalid please enter 1 to 100 days"
   exit 
elif [ $Days -le 0 ]
then
   echo "Days invalid please enter 1 to 100 days"
   exit
else
   echo "Days are valid"
fi
############################
find $LogPath -type f -iname '*.log' -mtime -$Days

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
