#!/bin/bash

selectedOutput=""
selectedOperation=""

selectDisplay() {
  listOutputsConnected=($(xrandr -q | grep " connected" | awk '{print $1}'))
  selectedOutput=$(zenity --list \
                      --title="Display configuration" \
                      --text="Select Output to configure." \
                      --width=800 \
                      --height=450 \
                      --column="Outputs" \
                      ${listOutputsConnected[@]} \
                      )
  echo "selectedOutput: $selectedOutput"
  if [[ $selectedOutput = ""  ]]; then
    exit
  fi
}

selectOperation() {
  selectedOperation=$(zenity --list \
                    --title="Display configuration" \
                    --text="Select Operation for Output $selectedOutput." \
                    --width=800 \
                    --height=450 \
                    --hide-column=1 \
                    --column="" --column="Operations" \
                    "resolution" "Set Resolution" \
                    "scale" "Set Scale" \
                    "orientation" "Set Orientation" \
                    "position" "Set Position" \
                    )
}

setResolution() {
  listOutputsAndResolutions=$(xrandr -q | grep -v "Screen ")
  listSelectedOutputResolutions=()
  addResolutionToList=false
  while IFS= read -r line
  do
    if [[ $(echo $line | grep "connected") != "" ]]; then
        addResolutionToList=false
    fi
    if [[ "$addResolutionToList" = true ]]; then
      listCorrectResolutions+=($(echo $line | awk '{print $1}' ))
    fi
    if [[ $(echo $line | grep "$selectedOutput") != "" ]]; then
        addResolutionToList=true
    fi
  done <<< "$listOutputsAndResolutions"
  
  selectedResolution=""
  selectedResolution=$(zenity --list \
                      --title="Display configuration" \
                      --text="Select resolution." \
                      --width=800 \
                      --height=450 \
                      --column="Resolutions" \
                      ${listCorrectResolutions[@]} \
                      )

  echo "selectedResolution: $selectedResolution"
  if [[ $selectedResolution = ""  ]]; then
    exit
  fi

  echo "xrandr --auto --output $selectedOutput --mode $selectedResolution"
  xrandr --auto --output $selectedOutput --mode $selectedResolution
}

setScale() {
  selectedScale=""
  selectedScale=$(zenity --list \
                    --title="Display configuration" \
                    --text="Select scale." \
                    --width=800 \
                    --height=450 \
                    --hide-column=1 \
                    --column="" --column="Scale" \
                    "0.5"   "50%" \
                    "0.625" "62.5%" \
                    "0.75"  "75%" \
                    "0.875" "87.5%" \
                    "1"     "100%" \
                    "1.25"  "125%" \
                    "1.5"   "150%" \
                    "1.75"  "175%" \
                    "2"     "200%" \
                    )
  echo "selectedScale: $selectedScale"
  if [[ $selectedScale = ""  ]]; then
    exit
  fi
  echo "xrandr --output $selectedOutput --scale $selectedScale"
  xrandr --output $selectedOutput --scale $selectedScale
}

setOrientation() {
  echo "Comming son."
}

setPosition() {
  echo "Comming son."
}

##################################################
## run functions
##################################################

selectDisplay
selectOperation
case $selectedOperation in
    resolution)
        setResolution
        ;;
    scale)
        setScale
        ;;
    orientation)
        setOrientation
        ;;
    position)
        setPosition
        ;;
    *)
        echo "option no valid"
        ;;
esac