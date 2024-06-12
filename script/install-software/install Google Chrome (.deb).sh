#!/bin/bash
wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo gdebi -n ./chrome.deb
rm chrome.deb
