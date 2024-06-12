#!/bin/bash

datos=$(zenity --forms \
               --title="test-form" \
               --text="Introduce los siguientes datos" \
               --add-entry="Nombre" \
               --add-password="Contraseña" \
               --add-calendar="Fecha de nacimiento" \
               --add-list="Resoluciones" \
               --show-header \
               --column-values="resolucion|detalle" \
               --list-values="1360x760||800x600|actual" \
               --add-combo="Resolution" \
               --combo-values="1360x768|1920x1080|1280x1024|1280x720|1024x768|800x600|720x576|720x480|640x480" \
               --add-combo="Escala" \
               --show-header \
               --combo-values="50%|60%|70%|80%|90%|100%|110%|120%|130%|140%|150%|160%|170%|180%|190%|200%" \
               )
echo $datos
