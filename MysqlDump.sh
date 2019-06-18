#!/bin/bash

#This script will going to take mysqldump of particulate database with current date and remove before 3 days dump file

Today="$(date "+%Y-%m-%d")"

#Before3Days="$(date "+%Y-%m-%d" --date '3 days ago')"

#rm -rf $Before3Days*

find . -mtime +3 -print -exec rm -rf *.sql '{}' \+

echo "please enter a db password"
read DBPassword

mysqldump --single-transaction=TRUE -uroot -p$DBPassword test > $Today.sql