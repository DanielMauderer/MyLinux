#!/usr/bin/env bash

# Change these names to your WireGuard connection names
VPN_DEFAULT="wg0"

ACTIVE_VPN=$(nmcli -t -f NAME,TYPE,DEVICE connection show --active \
  | awk -F: '$2=="wireguard"{print $1}')

if [[ -n "$ACTIVE_VPN" ]]; then
    nmcli connection down "$ACTIVE_VPN"
else
    nmcli connection up "$VPN_DEFAULT"
fi
