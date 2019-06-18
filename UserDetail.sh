#!/bin/bash
echo "Enter a username:"
read logname
line=$(grep $logname /etc/passwd)
if [ $? = 0 ]
then
   IFS=:
   set $line
   echo "User_Name : $1"
   echo "Password : $2"
   echo "User_ID : $3"
   echo "Group_ID : $4"
   echo "Comment_Fild : $5"
   echo "Home_folder : $6"
else
   echo "please enter a valid username"
fi
