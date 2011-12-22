#!/bin/bash

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
        echo ":source JOIN #d2005a" | tee -a $LOGFILE
    fi
}

function handle_privmsg {
    CMD=`echo $REPLY | cut -d" " -f 2`
    if [[ "$CMD" == "PRIVMSG" ]]; then
        MSG=`echo $REPLY | cut -d":" -f 3- `
        for file in plugins/*; do
            RESULT=`$file "$MSG"`
            if [[ "$RESULT" != "" ]]; then
                echo "PRIVMSG #d2005a :$RESULT" | tee -a $LOGFILE
            fi
        done;
    fi
}

