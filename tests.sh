#!/bin/bash

. ./settings.sh
. ./functions.sh

# Test kebabfredag plugin
REPLY=':sBUWK!~daniel@93.158.121.218 PRIVMSG #botting :.erekebabfredag'
handle_privmsg

# Test title reader
REPLY=':sBUWK!~daniel@93.158.121.218 PRIVMSG #botting :har ni sett http://www.ibm.com/developerworks/linux/library/l-sed2/index.html'
REPLY=':sBUWK!~daniel@93.158.121.218 PRIVMSG #botting :hej dn.se'
handle_privmsg

# Test CTCP VERSION
REPLY=':sBUWK!~daniel@93.158.121.218 PRIVMSG diggidanne :VERSION'
ctcp_version
