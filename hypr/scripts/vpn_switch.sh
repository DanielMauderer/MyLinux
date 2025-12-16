#!/usr/bin/env bash

VPN_LIST=("wg0")

ACTIVE=$(nmcli -t -f NAME,TYPE,DEVICE connection show --active \
  | awk -F: '$2=="wireguard"{print $1}')

# Pick next VPN
for i in "${!VPN_LIST[@]}"; do
    if [[ "${VPN_LIST[$i]}" == "$ACTIVE" ]]; then
        NEXT="${VPN_LIST[$(( (i+1) % ${#VPN_LIST[@]} ))]}"
        break
    fi
done

NEXT="${NEXT:-${VPN_LIST[0]}}"

[[ -n "$ACTIVE" ]] && nmcli connection down "$ACTIVE"
nmcli connection up "$NEXT"
