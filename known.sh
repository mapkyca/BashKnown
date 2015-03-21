#!/bin/bash
#
# Known Shell API caller
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# This is basically a wrapper around curl for posting things to the Known API from the shell
#
# Usage:
# 	./known http://mysite.com/endpoint user api_key data
#
#####

ACTION=$(echo -n $1 |cut -d'/' -f4-)
HMAC=$(echo -n "/$ACTION" | openssl dgst -binary -sha256 -hmac $3 |  base64 -w0)

curl -i -H "Accept: application/json" -X POST \
	-H "X-KNOWN-USERNAME: $2" \
	-H "X-KNOWN-SIGNATURE: $HMAC" \
	-d $4 $1
