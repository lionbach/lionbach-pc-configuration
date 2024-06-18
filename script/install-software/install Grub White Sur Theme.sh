#!/bin/bash
git clone git@github.com:vinceliuice/grub2-themes.git
cd grub2-themes
sudo ./install.sh -t stylish
cd ..
rm -rf grub2-themes
