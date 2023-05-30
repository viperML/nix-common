#!/usr/bin/env bash

source_hm() {
  local prefix="$1"
  local hm_vars="etc/profile.d/hm-session-vars.sh"
  local file="$prefix/$hm_vars"
  if [ -f "$file" ]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
}

source_hm "/etc/profiles/per-user/$USER"
source_hm "/nix/var/nix/profiles/per-user/$USER/profile"
source_hm "$HOME/.local/state/nix/profiles/profile"
