#!/bin/bash

#This script will take database dump.

USER="testingv4"
PASSWORD="testingv4"
#CURRENT_WEEK=$(date +%V)
DAY=$(date "+%Y-%m-%d")
HOST="127.0.0.1"
PORT="3307"
BACKUPDIR=$1
NOOFBACKUPCOPY=$2
DATADIR=$3
array=(Mobifin_eTransactions_Admin Mobifin_X1_Salaam Mobifin_X1_Wizall Mobifin_Calbank_Admin)


if [ -d $BACKUPDIR ]
then
  echo "$BACKUPDIR is available no need to create"
else
  mkdir -p  $BACKUPDIR
fi



cd $BACKUPDIR
mkdir $DAY
cd $DAY


BACKUPDIRSIZE=$(df -h $BACKUPDIR | grep 'dev' | awk '{print $4}' | sed 's/G//g')
DATADIRSIZE=$(du -sh $DATADIR | tr -dc '0-9')
SUM=10
REQDATADIRSIZE=`expr $DATADIRSIZE + $SUM`


if [ $BACKUPDIRSIZE -le $REQDATADIRSIZE ]
then
    for i in "${array[@]}"
    do
        mysqldump  --single-transaction=TRUE -u$USER -P$PORT -h $HOST -p$PASSWORD $i > $i.sql
    done
    echo "$(date) - Database backup taken successfully.."  >> ../Auditlog.txt
else
    echo "$(date) - Error...Required size is less then the backup." >> ../Auditlog.txt
    exit
fi


cd ..
tar -czvf $DAY.tar.gz $DAY
rm -rf $DAY


find $BACKUPDIR -type f -name '*.gz' -mtime +$NOOFBACKUPCOPY -exec rm -rf {} \;