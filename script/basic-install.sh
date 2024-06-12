#!/bin/bash

f_install_chrome(){
  wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo gdebi -n ./chrome.deb
  rm chrome.deb
}

f_config_chrome(){
  google-chrome https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb

  zenity \
  --info \
  --title="Instalando y Configurando Chrome" \
  --ellipsize \
  --text="\
  <b>Instalando y Configurando Chrome</b>

  <b>Perfil personal</b>
  Usaremos las cuantas leomumbach@gmail.com y lionbach01@gmail.com.
  Configurando Chrome desde una instalacion limpia.
  - Instalar la extension de Bitwarden a Chrome desde https://chromewebstore.google.com.
  - Iniciar sesion en Bitwarden (activamos recordar email).
  - Iniciar sesion en Chrome con leomumbach@gmail.com.
  - Validar inicio con celular.
  - Ir a chrome://settings/syncSetup -> manage what to sync -> customize sync -> desactivar:
      Passwords and passkeys.
      Addresses and more.
      Payment methods, offers, and addresses using Google Pay.
  - Volvemos a la pagina anterior y ir a setings de syncSetup -> turn on sync.
  - Vamos a www.google.com -> boton de cuenta de google (no confundir con boton del perfil de Chrome) -> agregar cuenta.
  - Iniciar sesion con lionbach01@gmail.com.
  - Si pregunta ¿Continuar en un nuevo perfil de Chrome? -> No.

  <b>Perfil de trabajo</b>
  Usaremos las cuantas leonardo@legalhub.com, ext.leonardo.mumbach@despegar.com y [meli acount here].
  - Clic boton del perfil de Chrome (barra superior a la derecha) -> add -> sing in.
  - Iniciar sesion en Chrome con leonardo@legalhub.com.
  - Validar inicio con celular.
  - Ir a chrome://settings/syncSetup -> manage what you sync -> customize sync -> desactivar:
      Passwords and passkeys.
      Addresses and more.
      Payment methods, offers, and addresses using Google Pay.
  - Volvemos a la pagina anterior y click en confirm.
  - Iniciar sesion en Bitwarden (activamos recordar email) (Bitwarden se instala automaticamente al sincronizar).
  - Vamos a www.google.com -> boton de cuenta de google (no confundir con boton del perfil de Chrome) -> agregar cuenta.
  - Iniciar sesion con ext.leonardo.mumbach@despegar.com.
  - Si pregunta ¿Continuar en un nuevo perfil de Chrome? -> No.
  - vamos a www.google.com -> boton de cuenta de google (no confundir con boton del perfil de Chrome) -> agregar cuenta.
  - Iniciar sesion con [meli acount here].
  - Si pregunta ¿Continuar en un nuevo perfil de Chrome? -> No.
  - Iniciar sesion en Github."
}

f_install_git(){
  sudo apt install -y git
}

f_config_git(){
  git_data=$(zenity \
    --forms \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\nConfigurando Git.\n" \
    --add-entry="Nombre" \
    --add-entry="Email" \
    --add-combo="Editor de Textos" \
    --combo-values="code|gedit|mousepad|nano|vi|xed" \
  )
  git_user="$(echo $git_data | cut -d '|' -f 1)"
  git_email="$(echo $git_data | cut -d '|' -f 2)"
  git_editor="$(echo $git_data | cut -d '|' -f 3)"
  git config --global user.name "$git_user"
  git config --global user.email "$git_email"
  git config --global core.editor "$git_editor"
}

f_create_ssh_key() {
  if [ -f ~/.ssh/id_ed25519.pub ]; then
    zenity --info \
      --title="Lionbach PC Configuration" \
      --width=900 \
      --height=600 \
      --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave SSH.</b>\nClave ssh id_ed25519.pub no se creo porque ya existe.\n"
  else
    # No borrar las lineas vacias, ya que equivalen a apretar enter.
    ssh-keygen -t ed25519 -C "$git_email" 2>/dev/null <<MSI

MSI
  zenity --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave SSH.</b>\nClave ssh id_ed25519.pub creada.\n"
  fi
}

f_add_ssh_key_in_github() {
  google-chrome --profile-email=leonardo@legalhub.la https://github.com/settings/ssh/new
  xclip -sel clip ~/.ssh/id_ed25519.pub
  xclip ~/.ssh/id_ed25519.pub

  zenity \
    --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --ellipsize \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Agregar clave SSH a Github</b>

- Se copio la clave ~/.ssh/id_ed25519.pub al portapapeles.
- Ir a https://github.com/settings/ssh/new
- Completar:
    titulo = titulo descriptivo de la pc
    Key type = Authentication key
    Key = pegar clave.
- Add ssh key."
}

f_create_gpg_key() {
  if [[ $(gpg --list-keys --keyid-format LONG | grep "pub   rsa4096/") != "" ]]; then
    google-chrome --profile-email=leonardo@legalhub.la https://github.com/despegar/test-signed-commits
    zenity --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave GPG.</b>\nYa existe una clave GPG, no se creara una nueva. Se asume que esa clave es la correcta. Si desea validar la clave vea https://github.com/despegar/test-signed-commits."
  else
    zenity --info \
    --title="Lionbach PC Configuration" \
    --width=900 \
    --height=600 \
    --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave GPG.</b>\nA continuacion se le pedira una contraseña, esta sera su frace para firmar los commits."
    frace=$(zenity --password --title="Frace clave GPG")
    ans=$?
    if [ $ans -eq 0 ]; then
      if [[ $frace != "" ]]; then
        echo "Key-Type: 1"             > gpg-options.txt
        echo "Key-Length: 4096"       >> gpg-options.txt
        echo "Subkey-Type: 1"         >> gpg-options.txt
        echo "Subkey-Length: 4096"    >> gpg-options.txt
        echo "Expire-Date: 0"         >> gpg-options.txt
        echo "Name-Real: $git_user"   >> gpg-options.txt
        echo "Name-Email: $git_email" >> gpg-options.txt
        echo "Passphrase: $frace"     >> gpg-options.txt
        gpg --full-gen-key --batch gpg-options.txt
        rm gpg-options.txt
        zenity --info \
          --title="Lionbach PC Configuration" \
          --width=900 \
          --height=600 \
          --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave GPG.</b>\nClave GPG generada."
      else
        zenity --info \
          --title="Lionbach PC Configuration" \
          --width=900 \
          --height=600 \
          --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave GPG.</b>\nFrace (contrseña) invalida, no se genero la clave."
      fi
    else
      zenity --info \
        --title="Lionbach PC Configuration" \
        --width=900 \
        --height=600 \
        --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Generando clave GPG.</b>\nFrace (contrseña) invalida, no se genero la clave."
    fi
  fi
}

f_add_gpg_key_in_github() {
  gpg_to_export=$(gpg --list-keys --keyid-format LONG | grep "pub   rsa4096/")
  gpg_to_export=${gpg_to_export:14:16}
  gpg --armor --export $gpg_to_export | xclip -sel clip
  gpg --armor --export $gpg_to_export | xclip
  google-chrome --profile-email=leonardo@legalhub.la https://github.com/settings/gpg/new
    zenity \
      --info \
      --title="Lionbach PC Configuration" \
      --ellipsize \
      --width=900 \
      --height=600 \
      --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n \
<b>Agregar clave GPG a Github</b>

- Se copio la clave GPG al portapapeles.
- Ir a https://github.com/settings/gpg/new
- Completar:
    titulo = titulo descriptivo de la pc
    Key = pegar clave.
- Add GPG key.
- Validar token de Authy."  
}

f_activate_sign_all_commits() {
  git config --global user.signingkey $gpg_to_export
  git config --global commit.gpgsign true
  zenity --info \
      --title="Lionbach PC Configuration" \
      --width=900 \
      --height=600 \
      --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Agregar clave GPG a Github.</b>\nAhora en esta PC todos los commits se firmaran con la clave GPG. No debe borrar la clave GPG de su cuenta de Github,\naun cuando ya no la use mas. Si la borra todos sus commits firmados con esa clave quedaran no verificados."
}

if [[ $(which google-chrome) == "" ]]; then
  f_install_chrome
fi
f_config_chrome

if [[ $(which git) == "" ]]; then
  f_install_git
fi
f_config_git
f_install_git
f_create_ssh_key
f_add_ssh_key_in_github
f_create_gpg_key
f_add_gpg_key_in_github
f_activate_sign_all_commits
