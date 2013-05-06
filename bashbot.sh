#!/bin/bash

# ---------------------------------------------------
# IRCBot in bash
# NOTE: $REPLY holds the last received data from read
# ---------------------------------------------------

# read settings from settings.sh
. ./settings.sh
. ./functions.sh

function handle_msg {
    # imported from functions.sh
    pong_if_needed
    join_if_connected
    handle_privmsg
    ctcp_version
}

control_c() {
    log "\n*** Keyboard interrupt, exiting ***\n"
    # Close socket
    exec 3>&- 
    echo "*** Bye bye ***"
    exit $?
}

trap control_c SIGINT

if ! exec 3<> /dev/tcp/$HOST/$PORT; then
    echo "ERROR CONNECTING"
    exit 1
fi

# Redirect stdin/stdout to socket
log "Redirecting stdin/stdout"
exec 1<&3
exec 0>&3

echo "NICK $NICK" | tee -a $LOGFILE
echo "USER $NAME * * :$NAME" | tee -a $LOGFILE

# main loop
while read; do
    handle_msg
    log "$REPLY"
done;
