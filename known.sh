#!/bin/bash
#
# Known Shell API caller
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# This is basically a wrapper around curl for posting things to the Known API from the shell
#
# Usage:
# 	echo "body=my data" | ./known http://mysite.com/endpoint user api_key
#
#####

ACTION=$(echo -n $1 |cut -d'/' -f4-)
HMAC=$(echo -n "/$ACTION" | openssl dgst -binary -sha256 -hmac $3 |  base64 -w0)

read data

# Temp cookie file
TFILE="/tmp/$(basename $0).$$.tmp"

curl -sS -c $TFILE -L -H "Accept: application/json" \
	-H "X-KNOWN-USERNAME: $2" \
	-H "X-KNOWN-SIGNATURE: $HMAC" \
	-d "$data" $1 | python -m json.tool

rm $TFILE
