#!/bin/env bash

exists() {
  command -v "$1" > /dev/null 2>&1
}

shutdown_w_error() {
  echo "$1"
  exit 1
}

shutdown() {
  echo "Success"
  exit 0
}

if ! exists nordvpn ; then
  shutdown_w_error "You need to install NordVPN and login first"
fi
if ! nordvpn status | grep -q "Logged in: Yes"; then
  shutdown_w_error "You are not logged in to NordVPN. Please log in first." 
fi

nordvpn set technology OpenVPN
  
nordvpn set obfuscate enabled

if nordvpn c; then 
  echo "Successfully connected to NordVPN using OpenVPN with obfuscation enabled"
  shutdown
else
  shutdown_w_error "Failed to connect to NordVPN"
fi

