#!/usr/bin/env bash

show_vpns_country(){
    echo $1;
    echo "**********";
    echo $results | tr -s ' ' '\n' | grep $2 | column -x;
}

results=$(ls -l /etc/openvpn/ | tr -s ' ' | cut -d ' ' -f 9 | grep ovpn);
