#!/bin/sh -e

if [ x"$SSH_AUTH_FROM" = x"etc/+plasma" ] && [ -n "$SSH_AGENT_PID" ]; then
  ssh-agent -k
fi
