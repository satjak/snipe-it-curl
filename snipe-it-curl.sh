

#!/bin/bash

#####VARIABLES########
#LOGIN
USERNAME="some read only user"
PASSWORD="some password"

#define a cookie file
CookieFileName=cookies.txt

SNIPE_IT="snipe-it.domain.com"
SEARCHSTRING="find me this"
###########################

#get the login token
token=`curl -s -c $TMPDIR/$CookieFileName -b $TMPDIR/$CookieFileName -X GET https://$SNIPE_IT/login | grep _token | cut -d '"' -f6`
#log into assets
login=`curl -s -X POST "https://$SNIPE_IT/login" -H "Accept: application/json" -c $TMPDIR/$CookieFileName -b $TMPDIR/$CookieFileName  --form "username=$USERNAME" --form "password=$PASSWORD" --form "_token=$token"`
#####STORE THE JSON BLOB####
asset_json=`curl -s --request GET --url "https://$SNIPE_IT/api/hardware/list?order_number=&search=$SEARCHSTRING&sort=asset_tag&order=desc&limit=1&offset=0" -H "Accept: application/json" -H "_token: $token" -c $TMPDIR/$CookieFileName -b $TMPDIR/$CookieFileName `