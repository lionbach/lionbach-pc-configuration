#!/bin/bash

# Primero obtener un array con la lista de archivos de la carpeta actual

ls_string=$(ls -m)
IFS=',' read -ra ls_array <<< "$ls_string"

ls_length=${#ls_array[*]}
echo $ls_length
for i in $ls_length
do
    echo "$1) "${ls_array[i]}
done

#ls_string=$(ls -m)
#i=0
#for archivo in "./"; do
#  i+=1
#  echo "$i) $archivo"
#done