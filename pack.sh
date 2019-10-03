#!/bin/bash
# Check current folder
location=`dirname $0`

rm "$location/rc.zip"
zip -r "$location/rc.zip" $location
read -p "Which server do you wish to send this to? (empty to skip)`echo $'\n> '`" fqdn
if [ "$fqdn" ]; then
    scp "$location/rc.zip" $fqdn:~/rc.zip
    rm $location/rc.zip
fi
