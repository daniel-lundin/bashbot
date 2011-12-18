#! /bin/bash

# ---------------------------------------------------
# IRCBot in bash
# NOTE: $REPLY holds the last received data from read
# ---------------------------------------------------

HOST=irc.quakenet.org
PORT=6667
NAME=bingoman
NICK=bingoman

LOGFILE="bashbot.log"

function log {
    echo $1 >> $LOGFILE
}

function pong_if_needed {
    if [[ "$REPLY" == PING* ]]; then
        PING_MSG=`echo $REPLY | cut -d" " -f2 `
        echo "PONG $PING_MSG" | tee -a $LOGFILE
    fi
}
function join_if_connected {
    RESPONSE_CODE=`echo $REPLY | cut -d" " -f2`
    if [[ "$RESPONSE_CODE" == "001" ]]; then
        log "001 found, attemping join"
        echo ":source JOIN #botting" | tee -a $LOGFILE
    fi
}

function handle_privmsg {
    CMD=`echo $REPLY | cut -d" " -f 2`
    if [[ "$CMD" == "PRIVMSG" ]]; then
        MSG=`echo $REPLY | cut -d":" -f 3- `
        log $MSG
        # Reply with "I'm here" if NICK found in msg
        if [[ "$MSG" == *$NICK* ]]; then
            echo "PRIVMSG #botting :I'm here" | tee -a $LOGFILE
        fi
    fi
}

function handle_msg {
    pong_if_needed
    join_if_connected
    handle_privmsg
}
if ! exec 3<> /dev/tcp/$HOST/$PORT; then
    echo "ERROR CONNECTING"
    exit 1
fi

# redict stdin/stdout to socket
log "Redirecting stdin/stdout"
exec 1<&3
exec 0>&3

echo "NICK $NICK" | tee -a $LOGFILE
read
pong_if_needed

echo "USER $NAME * * :$NAME" | tee -a $LOGFILE
read
pong_if_needed

# main loop
while read; do
    handle_msg
    log "$REPLY"
done;

# Close socket
exec 3>&- 
