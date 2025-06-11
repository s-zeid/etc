#!/bin/sh -e

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  export SSH_AUTH_FROM='etc/+plasma'
fi
