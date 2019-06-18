#!/bin/bash

# This script assumes that percona xtarbackup is installed on the system.

function checkIt()
{
 ps auxw | grep -P '\b'mysqld'(?!-)\b' >/dev/null
 if [ $? != 0 ]
 then
   echo "Mysqld Service is not Running";
   echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Mysqld Service is not Running!" >> $HOME_DIR/xtrabackup.log
   exit
 else
   echo "Mysqld Service is Running";
 fi;
}

checkIt "mysqld"


HOME_DIR=$3;
USER="root"
PASSWORD="xyz";
HOST=$1;
PORT=$2;
CURRENT_WEEK=$(date +%V);
DATA_DIR=$4;
TARGET_DIR="$HOME_DIR/$CURRENT_WEEK/base"

mkdir -p $TARGET_DIR
echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Full Backup Start!" >> $HOME_DIR/xtrabackup.log
xtrabackup --user=$USER --password="$PASSWORD" --host=$HOST --port=$PORT --backup --target-dir=$TARGET_DIR
echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Full Backup Done!" >> $HOME_DIR/xtrabackup.log