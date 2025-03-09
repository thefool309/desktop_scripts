#!/bin/bash

# did this just for a quicker way to show off the chameleon
# that doesn't involve changing the distro's built in ascii
if command -v hyfetch &> /dev/null
then
    hyfetch --distro openSUSE
else
    neofetch --ascii_bold on --ascii_distro openSUSE --gpu_brand on --gpu_type all
fi