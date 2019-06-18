#! /bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Select what you want to deploy" \
	--title "auto deployment" --clear \
        --checklist "Hi, you can select what you want to deploy  " 20 61 15 \
        "Admin"  "Admin Portel"  off \
        "WebPortel" "Web Portel"  off \
        "Redis" "RedisDB Server"  off \
        "HSM" "HSM Services"  off \
        "Mysql" "MysqlDB Server" off \
        "CM" "Communication Manager" off  2> $tempfile

retval=$?

choice=`cat $tempfile`
case $retval in
  0)
    echo "'$choice' youm are Deploying";;
  1)
    echo "Cancel pressed.";;
  255)
    echo "ESC pressed.";;
esac
