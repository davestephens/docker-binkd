#!/bin/sh

if [ $UPLINKS == "NONE" ]; then
    echo "No uplinks defined, exiting."
    exit
fi

for uplink in "${UPLINKS[@]}"

do
    /usr/local/sbin/binkd -p -P $uplink /config/binkd.conf
done
