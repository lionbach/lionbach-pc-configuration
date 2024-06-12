#!/bin/bash

f_delete_software_menu(){
  local opcion=$(zenity \
    --list \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --checklist \
    --separator=" " \
    --print-column=3 \
    --hide-column=3 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Mint Minimal</b>\nSeleccione software a desinstalar." \
    --column="" --column="Name"      --column="Packages" \
    false       "Calculator"           "gnome-calculator" \
    false       "Celluloid"            "celluloid" \
    false       "Character Map"        "gucharmap" \
    false       "Disk usage analyzer"  "baobab" \
    false       "Drawing"              "drawing" \
    false       "Document Scanner"     "simple-scan" \
    false       "Fonts"                "gnome-font-viewer" \
    false       "Gnome-Power-Manager"  "gnome-power-manager" \
    false       "HexChat"              "hexchat" \
    false       "Hypnotix"             "hypnotix" \
    false       "Library"              "thingy" \
    false       "Libre Office"          "libreoffice-* libmythes-1.2-0 mythes-* liblibreoffice-java hunspell hunspell-* ure ure-java python3-uno uno-libs-private hyphen-* libuno-cppu3 libuno-cppuhelpergcc3-3 libunoloader-java libuno-purpenvhelpergcc3-3 libuno-sal3 libuno-salhelpergcc3-3" \
    false       "Notes"                "sticky" \
    false       "Onboard"              "onboard" \
    false       "Passwords and Keys"   "seahorse" \
    false       "Pix"                  "pix pix-dbg" \
    false       "Redshift"             "redshift-gtk" \
    false       "Rhythmbox"            "librhythmbox-core10 rhythmbox rhythmbox-*" \
    false       "Thunderbird"          "thunderbird thunderbird-gnome-support thunderbird-locale-*" \
    false       "Transmission"         "transmission-gtk" \
    false       "Warpinator"           "warpinator" )
  echo "$opcion"
}

f_hide_icons_menu(){
  local opcion=$(zenity --title="Mint Minimal" \
    --list \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --hide-column=1 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Mint Minimal</b>\n¿Ocultar iconos redundantes del menu de aplicaciones, que se pueden acceder desde system settings?\n" \
    --column="" --column="Menu" \
    1           "Si" \
    2           "No" )
  echo "$opcion"
}

f_password(){
  zenity \
    --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\nIngrese la contraseña para sudo." \
    --ok-label="Ingresar Contraseña"
  local sudopass=$(zenity --password --title="Lionbach PC Configuration")
  echo "$sudopass"
}

delete_software_list=$(f_delete_software_menu)
hide_icons_list=$(f_hide_icons_menu)

if [[ $delete_software_list != "" ]]; then
  # actualizando
  f_password | sudo -S apt update
  sudo apt remove -y $delete_software_list
  sudo apt autoremove
  sudo apt update
fi

hide_app_icon(){
  local app_patron=$1
  mkdir -p ~/.local/share/applications
  cp /usr/share/applications/$app_patron* ~/.local/share/applications/
  local text_files=$(ls ~/.local/share/applications/ | grep $app_patron)
  local array_files=($text_files)
  local i=0
  for i in "${array_files[@]}"; do
    echo "NoDisplay=true" >> ~/.local/share/applications/$i
  done
}

if [[ $hide_icons_list == "1" ]]; then
  hide_app_icon "cinnamon-settings-*"
  hide_app_icon "cinnamon-display-panel.desktop"
  hide_app_icon "cinnamon-color-panel.desktop"
  hide_app_icon "cinnamon-network-panel.desktop"
  hide_app_icon "cinnamon-onscreen-keyboard.desktop"
  hide_app_icon "cinnamon-wacom-panel.desktop"
  hide_app_icon "lightdm-settings.desktop"
  hide_app_icon "mintsources.desktop"
  hide_app_icon "blueman-manager.desktop"
  hide_app_icon "mintdrivers.desktop"
  hide_app_icon "gufw.desktop"
  hide_app_icon "mintlocale.desktop"
  hide_app_icon "mintlocale-im.desktop"
  hide_app_icon "system-config-printer.desktop"
fi
