#!/bin/bash

main_dir=$(pwd)

f_generate_env_file(){
  if [ ! -f env.json ]; then
    echo '
    {    
        "project_dir": "3/home/lion bach/projects"
    }
    ' | jq >env.json

    zenity \
    --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\nComplete los datos de archivo env.json.\n" \
    --ok-label="Editar archivo"
    
    x-terminal-emulator -e "nano -l env.json"
  fi
  #creamos variables con valores de env.json
  project_dir=$(jq -r '.project_dir' env.json)
}

f_init_config(){
  zenity \
    --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\nIngrese la contraseña para sudo." \
    --ok-label="Ingresar Contraseña"
  sudopass=$(zenity --password --title="Lionbach PC Configuration")
  echo $sudopass | sudo -S apt update
  echo $sudopass | sudo -S apt install -y zenity jq curl wget gdebi xclip
  f_generate_env_file
}

f_show_menu(){
  local menu_option=$(zenity \
  --list \
  --title="Lionbach PC Configuration" \
  --width=900 \
  --height=600 \
  --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\nSeleccione la configuracion a realizar.\n" \
  --hide-column=1 \
  --column="id" \
  --column="Opcion" \
  --column="Detalle" \
  "basicinstall" "Instalacion Basica"     "Instalar chrome, bitwarden (extencion) y git, y configurar cuentas." \
  "minti3"       "Mint-i3wm-cinnamon"     "Solo para Linux Mint 21 - Configurar para usar i3wm en cinnamon." \
  "mintmini"     "Mint Minimal"           "Solo para Linux Mint 21 - Desinstalar programas y ocultar iconos redundantes." \
  "install"      "Instalar programas"     "Instalar programas generales." \
  "installdev"   "Instalar programas Dev" "Instalar programas de trabajo y programacion." \
  )
  echo $menu_option
}

f_init_config

main_menu_option=$(f_show_menu)
while [[ $main_menu_option != "" ]]; do
  cd $main_dir
  case $main_menu_option in
    "basicinstall")
      cd script/
      bash basic-install.sh
      cd $main_dir
      ;;
    "minti3")
      mkdir -p $project_dir
      cd $project_dir
      git clone https://github.com/lionbach/mint-i3wm-cinnamon.git
      cd mint-i3wm-cinnamon
      bash main.sh
      cd $main_dir
      ;;
    "mintmini")
      cd script/
      bash mint-mini.sh
      cd $main_dir
      ;;
    "install")
      cd script/install-software
      bash 01-install-software.sh
      cd $main_dir
      ;;
    "installdev")
      cd script/install-software-dev
      bash 01-install-software.sh
      cd $main_dir
      ;;
    *)
      echo "opcion no valida"
      ;;
  esac
  main_menu_option=$(f_show_menu)
done
