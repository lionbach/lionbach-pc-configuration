#!/bin/bash
wget -O temp.deb "https://filestore.fortinet.com/forticlient/forticlient_vpn_7.4.0.1636_amd64.deb"
sudo gdebi -n ./temp.deb
rm temp.deb
sudo systemctl disable forticlient
