#!/bin/sh

function IsRunning() {
    return pgrep screenkey
}

if ! pgrep screenkey > /dev/null
then
    screenkey --mods-mode win -t 1 -s small --opacity 0.2
else
    killall screenkey
fi

