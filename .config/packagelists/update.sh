#!/bin/bash

echo $(cut -d' ' -f1 <(paclist aur)) > /home/patrickpmueller/.config/packagelists/aurlist
echo $(pacman -Qeq) > /home/patrickpmueller/.config/packagelists/paclist
