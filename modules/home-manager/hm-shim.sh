#!/bin/sh

source_hm() {
  _prefix="$1"
  _hm_vars="etc/profile.d/hm-session-vars.sh"
  _file="$_prefix/$_hm_vars"
  if [ -f "$_file" ]; then
    # shellcheck source=/dev/null
    . "$_file"
  fi
}

for _profile in $NIX_PROFILES; do
  source_hm "$_profile"
done
