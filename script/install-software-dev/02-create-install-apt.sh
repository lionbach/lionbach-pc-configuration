#!/bin/bash

# Uso:
# bash 02-create-install-apt.sh <apt-package-name> <title>
# Ejemplo
# bash 02-create-install-apt.sh "kolourpaint breeze" "KolourPaint"

package=$1
title=$2
echo "#!/bin/bash
sudo apt install -y $package" > "install $title.sh"
