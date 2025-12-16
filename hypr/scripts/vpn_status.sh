#!/usr/bin/env bash

VPN=$(nmcli -t -f NAME,TYPE connection show --active \
  | awk -F: '$2=="wireguard"{print $1}')

if [[ -n "$VPN" ]]; then
    echo " $VPN"
else
    echo " VPN"
fi