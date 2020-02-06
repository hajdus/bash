#!/bin/bash

function monitor {

 	mv $1_new.html $1_old.html 2> /dev/null
    curl $2 -L --compressed -s | tr " " "\n" > $1_temp.html
    grep -A 2 'datePublished' $1_temp.html > $1_new.html
    cp $1_new.html new.html 
    cp $1_old.html old.html 
         
    DIFF_OUTPUT="$(diff new.html old.html)"
    Text="New version of "$1" is now available in Google Play"
     if [ "0" != "${#DIFF_OUTPUT}" ]; then
        				
        	URL='http://sdplus:8080/sdpapi/request/?OPERATION_NAME=ADD_REQUEST&TECHNICIAN_KEY=?????&INPUT_DATA=<Operation><Details><parameter><name>requester</name><value>New_APK</value></parameter><parameter><name>subject</name><value>'$1'</value></parameter><parameter><name>description</name><value>'$Text'</value></parameter></Details></Operation>'
			curl -G "$( echo "$URL" | sed 's/ /%20/g' )"
			
        sleep 10
     fi

}

for (( ; ; )); do

   monitor WhatsApp "https://play.google.com/store/apps/details?id=com.whatsapp&hl=pl"
   monitor Yammer "https://play.google.com/store/apps/details?id=com.yammer.v1&hl=pl"
   
	echo "Wait..."
    sleep 10
done
