#!/bin/sh

if [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
  # shellcheck source=/dev/null
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
fi

if [ -f "/nix/var/nix/profiles/per-user/$USER/profile/etc/profile.d/hm-session-vars.sh" ]; then
  # shellcheck source=/dev/null
  . "/nix/var/nix/profiles/per-user/$USER/profile/etc/profile.d/hm-session-vars.sh"
fi

