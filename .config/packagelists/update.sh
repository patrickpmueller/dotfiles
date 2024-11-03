#!/bin/bash

echo "$(cut -d' ' -f1 <(paclist aur))\n" > /home/patrickpmueller/.config/packagelists/aurlist
echo "$(pacman -Qeq)\n" > /home/patrickpmueller/.config/packagelists/paclist
