#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 {p_laptop|w_laptop|w_laptop_1Monitor|w_laptop_2Monitors}"
  exit 1
}

env_name="${1:-}"
case "$env_name" in
  p_laptop|w_laptop|w_laptop_1Monitor|w_laptop_2Monitors) ;;
  *) usage ;;
esac

conf_dir="${HOME}/.config/hypr/conf"

if [[ ! -f "${conf_dir}/monitors/${env_name}.lua" ]]; then
  echo "Missing: ${conf_dir}/monitors/${env_name}.lua"
  exit 1
fi
if [[ ! -f "${conf_dir}/workspaces/${env_name}.lua" ]]; then
  echo "Missing: ${conf_dir}/workspaces/${env_name}.lua"
  exit 1
fi

printf 'require("conf.monitors.%s")\n' "$env_name" > "${conf_dir}/monitor.lua"
printf 'require("conf.workspaces.%s")\n' "$env_name" > "${conf_dir}/workspace.lua"

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload || true
fi

echo "Hyprland environment switched to: ${env_name}"


