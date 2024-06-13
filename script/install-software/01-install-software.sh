#!/bin/bash

dir_files=(*)
dir_files_filter_content=()
dir_files_filter_title=()

for i in "${dir_files[@]}";do
  if [[ ${i:0:8} == "install " ]] && [[ ${i:(-3)} == ".sh" ]] && [[ -f "$i" ]];then
    dir_files_filter_content+=("$i")
    dir_files_filter_title+=("${i:8:-3}")
  fi
done

zenity_comand='zenity \
--list \
--title="Lionbach PC Configuration" \
--width=900 \
--height=600 \
--text="\n<span size='
zenity_comand+="'16pt'"
zenity_comand+='><b>Lionbach PC Configuration</b></span>\n\n<b>Instalar programas</b>\nSeleccion programas a instalar\n" \
--separator=" " \
--checklist \
--column="" \
--column="Id" \
--column="Software" '

for i in "${!dir_files_filter_title[@]}"; do
  zenity_comand+=" 0 $i \"${dir_files_filter_title[$i]}\""
done

software_to_install=$(eval "$zenity_comand")
software_to_install_array=($software_to_install)
ans=$?

if [ $ans -eq 0 ];then
  for i in "${software_to_install_array[@]}";do
    eval "bash '${dir_files_filter_content[i]}'"
  done
fi
