#!/bin/bash

datos=$(zenity --forms \
               --title="test-form" \
               --modal \
               --text="Introduce los siguientes datos" \
               --add-combo="Resolution" \
               --combo-values="1360x768|1920x1080|1280x1024|1280x720|1024x768|800x600|720x576|720x480|640x480" \
               --add-combo="Scale" \
               --combo-values="50%|60%|70%|80%|90%|100%|110%|120%|130%|140%|150%|160%|170%|180%|190%|200%" \
               --add-combo="Rotate" \
               --combo-values="normal|inverted|left|right" \
               --add-combo="Position" \
               --combo-values="left of <A>|right of <A>|above <A>|below <A>|left of <B>|right of <B>|above <B>|below <B>" \
               )
echo $datos