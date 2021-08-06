#!/bin/sh

WORKAROUND="$HOME/bin/private/cros-procfs-workaround"


if [ -e /dev/.cros_milestone ]; then
 if ! (pgrep -f "$WORKAROUND" >/dev/null 2>&1); then
  for name in cpuinfo diskstats meminfo stat uptime; do
   if fgrep -q -e "/proc/$name" /proc/mounts; then
    echo + "$WORKAROUND" >&2
    break
   fi
  done
  command "$WORKAROUND"
 fi
fi
