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

echo $sudopass | sudo -S apt update
# Instala cualquiera de los siguientes componentes adicionales.

components_to_install=$(zenity \
--list \
--title="Google Cloud CLI - Instalar componentes adicionales" \
--text="Google Cloud CLI - Instalar componentes adicionales." \
--width=900 \
--height=600 \
--separator=" " \
--checklist \
--column="" \
--column="Componente" \
0 "google-cloud-cli-anthos-auth" \
0 "google-cloud-cli-app-engine-go" \
0 "google-cloud-cli-app-engine-grpc" \
0 "google-cloud-cli-app-engine-java" \
0 "google-cloud-cli-app-engine-python" \
0 "google-cloud-cli-app-engine-python-extras" \
0 "google-cloud-cli-bigtable-emulator" \
0 "google-cloud-cli-cbt" \
0 "google-cloud-cli-cloud-build-local" \
0 "google-cloud-cli-cloud-run-proxy" \
0 "google-cloud-cli-config-connector" \
0 "google-cloud-cli-datastore-emulator" \
0 "google-cloud-cli-firestore-emulator" \
0 "google-cloud-cli-gke-gcloud-auth-plugin" \
0 "google-cloud-cli-kpt" \
0 "google-cloud-cli-kubectl-oidc" \
0 "google-cloud-cli-local-extract" \
0 "google-cloud-cli-minikube" \
0 "google-cloud-cli-nomos" \
0 "google-cloud-cli-pubsub-emulator" \
0 "google-cloud-cli-skaffold" \
0 "google-cloud-cli-spanner-emulator" \
0 "google-cloud-cli-terraform-validator" \
0 "google-cloud-cli-tests" \
0 "kubectl")

if [[ $components_to_install != "" ]]; then
  echo $sudopass | sudo -S apt install -y $components_to_install
fi
