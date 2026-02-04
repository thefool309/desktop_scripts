#!/bin/env bash

#! remains untested !#

obfuscate=$1



exists() {
  command -v "$1" &> /dev/null 2>&1
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
if ! nordvpn account | grep -q "Account Information"; then
  shutdown_w_error "You are not logged in to NordVPN. Please log in first."
fi



if [ "$obfuscate" == "obfuscate" ]; then
  
  nordvpn set technology OpenVPN 
  nordvpn set obfuscate enabled
  
  if nordvpn c; then 
    echo "Successfully connected to NordVPN using OpenVPN with obfuscation enabled"
    shutdown
  else
    shutdown_w_error "Failed to connect to NordVPN"
  fi
elif [ "$obfuscate" == "deobfuscate" ]; then
  
  nordvpn set obfuscate disabled
  nordvpn set technology NordLynx

  if nordvpn c; then 
    echo "Successfully connected to NordVPN using NordLynx with obfuscation disabled"
    shutdown
  else
    shutdown_w_error "Failed to connect to NordVPN"
  fi
else
  shutdown_w_error "You made a mistake \n Usage: nord_set_obfuscate.sh <obfuscate/deobfuscate>"
fi

