#!/bin/bash
#
# Known Shell Status message poster
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# Wrapper around known.sh that posts a status message. Assumes known.sh is on your path.
#
# Usage:
# 	echo "my status message" | ./status.sh http://mysite.com user api_key syndication....
#
#####

read post

if [ $# -lt 3 ]; then
	echo "Usage: echo \"my status message\" | $0 https://mysite.com user api_key [syndication]"
	exit
fi

data=$(echo -n "$post" | php -r "echo urlencode(file_get_contents('php://stdin'));")

syndication="${@:4}"
syn=""

for word in $syndication;
	do 
	enc=$(echo -n $word | php -r  "echo urlencode(file_get_contents('php://stdin'));");
	syn="${syn}syndication%5B%5D=$enc&";
done

echo "${syn}body=$data" | known.sh "$1/status/edit" $2 $3
