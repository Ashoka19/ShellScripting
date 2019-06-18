#!/bin/bash


first_month=Before_OneMonth_log
second_month=Before_TwoMonth_log



#First_LOG=/opt/Request
#mkdir -p /home/dev_usr/$First_LOG
Second_LOG=/opt/Request2
mkdir -p /home/dev_usr/$Second_LOG

# Before One month log will Tar.
find $Second_LOG -mtime +30 -mtime -60 -print -exec tar -zcvf /$Second_LOG/${first_month}.tar.gz '{}' \+

find $Second_LOG -mtime +30 -mtime -60 -print -exec rm -f '{}' \+

find $Second_LOG -mtime +30 -mtime -90 -print -exec tar -zcvf /$Second_LOG/${second_month}.tar.gz '{}' \+

find $Second_LOG -mtime +30 -mtime -90 -print -exec rm -f '{}' \+

# Before Three moths log tar will move to other location.

#find $Second_LOG -mtime +90 -print -exec tar -zcvf /home/dev_usr/$Second_LOG/${third_month}.tar.gz '{}' \+

declare -a arr=("Jan-2017" "Feb-2017" "Mar-2017" "Apr-2017" "May-2017" "Jun-2017" "Jul-2017" "Aug-2017" "Sept-2017" "Oct-2017" "Nov-2017" "Dec-2017");

for i in "${arr[@]}"
do
   find $Second_LOG -newermt "01-$i -1 sec" -and -not -newermt "01-$i +1 month -1 sec" -exec tar -cvzf /home/dev_usr/$Second_LOG/"$i".tar.gz '{}' \+
        echo "======================="
   # or do whatever with individual element of the array
done

########################################################
declare -a arr=("Jan-2018" "Feb-2018" "Mar-2018" "Apr-2018" "May-2018" "Jun-2018" "Jul-2018" "Aug-2018" "Sept-2018" "Oct-2018" "Nov-2018");

for i in "${arr[@]}"
do
    find $Second_LOG -newermt "01-$i -1 sec" -and -not -newermt "01-$i +1 month -1 sec" -exec tar -cvzf /home/dev_usr/$Second_LOG/"$i".tar.gz '{}' \+
        echo "======================="
   # or do whatever with individual element of the array
done