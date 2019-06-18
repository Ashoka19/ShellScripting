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
DAY=$(date +"%a");
PREVIOUS_DAY=$(date --date="yesterday" | cut -d ' ' -f1);
TARGET_DIR="$HOME_DIR/$CURRENT_WEEK/$DAY"

if [ "$DAY" == "Tue" ]
        then
                if [ -d "$HOME_DIR/$CURRENT_WEEK/base" ]
                        then
                                mkdir -p $TARGET_DIR
								echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Incremental-1 Backup Start!" >> $HOME_DIR/xtrabackup.log
                                xtrabackup --user=$USER --password="$PASSWORD" --host=$HOST --port=$PORT --backup --target-dir=$TARGET_DIR --incremental-basedir=$HOME_DIR/$CURRENT_WEEK/base 
								echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Incremental-1 Backup Done!" >> $HOME_DIR/xtrabackup.log
                else
                                echo "Percona Error $HOME_DIR/$CURRENT_WEEK/base not present" >> $HOME_DIR/xtrabackup.log
                fi
else
                if [ -d "$HOME_DIR/$CURRENT_WEEK/$PREVIOUS_DAY" ]
                        then
                                mkdir -p $TARGET_DIR
								echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Incremental-2 Backup Start!" >> $HOME_DIR/xtrabackup.log
                                xtrabackup --user=$USER --password="$PASSWORD" --host=$HOST --port=$PORT --backup --target-dir=$TARGET_DIR --incremental-basedir=$HOME_DIR/$CURRENT_WEEK/$PREVIOUS_DAY 
								echo `date '+%Y-%m-%d %H:%M:%S:%s'`": Incremental-2 Backup Done!" >> $HOME_DIR/xtrabackup.log
                        else
                                echo "Percona Error $HOME_DIR/$CURRENT_WEEK/$PREVIOUS_DAY not present" >> $HOME_DIR/xtrabackup.log
                fi
fi