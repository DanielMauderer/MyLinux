#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 {p_laptop|w_laptop}"
  exit 1
}

env_name="${1:-}"
case "$env_name" in
  p_laptop|w_laptop) ;;
  *) usage ;;
esac

conf_dir="${HOME}/.config/hypr/conf"

if [[ ! -f "${conf_dir}/monitors/${env_name}.conf" ]]; then
  echo "Missing: ${conf_dir}/monitors/${env_name}.conf"
  exit 1
fi
if [[ ! -f "${conf_dir}/workspaces/${env_name}.conf" ]]; then
  echo "Missing: ${conf_dir}/workspaces/${env_name}.conf"
  exit 1
fi

printf 'source = ~/.config/hypr/conf/monitors/%s.conf\n' "$env_name" > "${conf_dir}/monitor.conf"
printf 'source = ~/.config/hypr/conf/workspaces/%s.conf\n' "$env_name" > "${conf_dir}/workspace.conf"

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload || true
fi

echo "Hyprland environment switched to: ${env_name}"


