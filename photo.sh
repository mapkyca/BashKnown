#!/bin/bash
#
# Known Shell photo message poster
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# Wrapper around known.sh that posts a photo message. Assumes known.sh is on your path.
#
# Usage:
# 	echo "body message" | ./photo.sh http://mysite.com user api_key title filename 
#
# At the moment syndication isn't supported, because I ran out of time working out the shell script.
#
#####

read post

if [ $# -lt 5 ]; then
	echo "Usage: echo \"body message\" | $0 https://mysite.com user api_key title filename"
	exit
fi

syndication="${@:6}"
syn=""

for word in $syndication;
	do 
	enc=$(echo -n $word | php -r  "echo urlencode(file_get_contents('php://stdin'));");
	syn="${syn}syndication%5B%5D=$enc&";
done

#echo "${syn}title=${4}&body=${data}&photo=@${5};filename=alert.jpg;type=image/jpeg" | known.sh "$1/photo/edit" $2 $3


ACTION='photo/edit'
HMAC=$(echo -n "/$ACTION" | openssl dgst -binary -sha256 -hmac $3 |  base64 -w0)

NEWDATA="${syn}title=${4}&body=${data}"

# Temp cookie file
COOKIE="/tmp/$(basename $0).$$.tmp"

NAME=$(basename $5)
TYPE=$(file -b --mime-type $5)

curl -sS -c $COOKIE -L \
	-H "Accept: application/json" \
        -H "X-KNOWN-USERNAME: $2" \
        -H "X-KNOWN-SIGNATURE: $HMAC" \
	-H "Content-Type: multipart/form-data"  \
        -F "photo[]=@${5};filename=$NAME;type=$TYPE" \
        -F "title=${4}" \
	-F "body=${post}" \
	$1/photo/edit | python -m json.tool

rm $COOKIE

