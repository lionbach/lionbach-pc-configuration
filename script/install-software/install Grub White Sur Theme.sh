#!/bin/bash
git clone git@github.com:vinceliuice/grub2-themes.git
cd grub2-themes
sudo ./install.sh -t whitesur 
cd ..
rm -rf grub2-themes
