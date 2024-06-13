#!/bin/bash

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
sudopass=$(f_password)

zenity --info \
  --title="Lionbach PC Configuration" \
  --width=900 \
  --height=600 \
  --text="\n<span size='16pt'><b>Lionbach PC Configuration</b></span>\n\n<b>Google Cloud CLI.</b>\nSe agregara repositorio e instalara Google Cloud CLI."

zenity --info --title="Contraseña Sudo" --width=900 --height=600 --text="Ingrese la contraseña para sudo."

# 1. Importa la clave pública de Google Cloud.
echo $sudopass | sudo -S apt update
echo $sudopass | sudo -S apt install -y apt-transport-https ca-certificates gnupg curl

# 2. Agrega el URI de distribución de gcloud CLI como una fuente de paquetes.
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# 3. Instala y actualiza gcloud CLI.
echo $sudopass | sudo -S apt update
echo $sudopass | sudo -S apt install -y google-cloud-cli

# 4. (Opcional) Instala cualquiera de los siguientes componentes adicionales.
bash "install Google Cloud CLI - Componentes Extra.sh"

# 5. Ejecuta gcloud init para comenzar.
x-terminal-emulator -e "gcloud init"

