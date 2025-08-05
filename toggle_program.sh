#!/bin/sh

function is_running() {
    pgrep $1
}

# Run the command the user provided. If it's already running, kill it.
if [ -z $1 ]
then
    # No arguments given
    false
else
    if ! is_running $1 > /dev/null
    then
        eval $@
    else
        killall $1
    fi
fi
