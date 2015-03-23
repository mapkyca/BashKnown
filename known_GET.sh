#!/bin/bash
#
# Known Shell API GET caller
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# This is basically a wrapper around curl for making GET queries against the api
#
# Usage:
# 	./known_GET http://mysite.com/endpoint user api_key
#
#####

ACTION=$(echo -n $1 |cut -d'/' -f4-)
HMAC=$(echo -n "/$ACTION" | openssl dgst -binary -sha256 -hmac $3 |  base64 -w0)

# Temp cookie file
TFILE="/tmp/$(basename $0).$$.tmp"

curl -sS -c $TFILE -L -H "Accept: application/json" \
	-H "X-KNOWN-USERNAME: $2" \
	-H "X-KNOWN-SIGNATURE: $HMAC" \
	$1 | python -m json.tool

rm $TFILE
