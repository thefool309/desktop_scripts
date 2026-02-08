#!/bin/bash
echo "Blahaj?(y/n):"
read -r result
if [ "$result" = "y" ]; then
    echo "Yay :3"
else
    echo "Y No Blahaj? ;-;"
fi
