#!/bin/sh

SILENCE="$(cd "$(dirname -- "$__script")/../_bin" && pwd)/silence"


if [ -f "/usr/lib/systemd/user/cros-pulse-config.service" ]; then
 if ! (pgrep -f "/usr/bin/pulseaudio" >/dev/null 2>&1); then
  systemctl --user restart cros-pulse-config.service
 fi
fi

if ! (pgrep -f "$SILENCE" >/dev/null 2>&1); then
 setsid "$SILENCE"
fi


unset SILENCE
