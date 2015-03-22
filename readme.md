Known BASH API tools
====================

This is a collection of bash command line tools for interfacing with the Known api.

It uses the user api token (available from your tools and apps menu) in order to interface with your known site.

This is quite handy, you can for example use it to send a tweet from the command line (as I do), or as part of the 
"internet of things" to allow system processes to send messages to a Known powered status page (as I also do).

Requirements
------------
* curl
* php cli
* python
* openssl
* base64

The last should be part of your distro's core utils package.

Example
-------

Send a status message, and send it to twitter.

echo "my tweet" | ./status.sh https://mysite.com me myaccesscode twitter::username

Licence
-------

GPL 2

See
---

* Author: Marcus Povey http://www.marcus-povey.co.uk
