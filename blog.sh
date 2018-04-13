#!/bin/bash
#
# Known Shell long post poster
# Author: Marcus Povey <https://www.marcus-povey.co.uk>
#
# Wrapper around known.sh that posts a long message. Assumes known.sh is on your path.
# First line is your title, the rest is your body
#
# Usage:
# 	cat blog.txt | ./blog.sh http://mysite.com user api_key syndication....
#
#####

read title

if [ $# -lt 3 ]; then
	echo "Usage: cat blog.txt | $0 https://mysite.com user api_key [syndication]"
	exit
fi

title=$(echo -n "$title" | php -r "echo urlencode(file_get_contents('php://stdin'));")

data=''
while read line;
	do data="${data}$line<br />";
done
data=$(echo -n "$data" | php -r "echo urlencode(file_get_contents('php://stdin'));")

syndication="${@:4}"
syn=""

for word in $syndication;
	do
	enc=$(echo -n $word | php -r  "echo urlencode(file_get_contents('php://stdin'));");
	syn="${syn}syndication%5B%5D=$enc&";
done

echo "${syn}title=$title&body=$data" | known.sh "$1/entry/edit" $2 $3
