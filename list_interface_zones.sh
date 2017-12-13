#!/bin/bash

if which ifconfig > /dev/null; then
    for f
    in $(
        ifconfig |
        grep 'BROADCAST' |
        awk '{print substr($1, 1, length($1)-1)}'
    )
    do
        echo -ne "zone of interface ${f}: "
        echo $(firewall-cmd --get-zone-of-interface=${f})
    done
else
    for f
    in $(
        ip addr |
        grep 'BROADCAST' |
        awk '{print substr($2, 1, length($2)-1)}' |
        cut -f1 -d"@"
    )
    do
        echo -ne "zone of interface ${f}: "
        echo $(firewall-cmd --get-zone-of-interface=${f})
    done
fi
