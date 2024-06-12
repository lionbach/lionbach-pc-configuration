#!/bin/bash
#!/bin/bash
wget -O temp.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo gdebi -n ./temp.deb
rm temp.deb
