#!/bin/bash

displayGetOutputs(){
    local outputs=($(xrandr -q | grep "connected" | awk '{print $1}'))
    echo $outputs
}

displayGetOutputsConnected(){
    local outputs=($(xrandr -q | grep " connected" | awk '{print $1}'))
    echo $outputs
}

displayGetOutputsDisconnected(){
    local outputs=($(xrandr -q | grep "disconnected" | awk '{print $1}'))
    echo $outputs
}

displayGetResolutions(){
  local output=$1
  local xrandrData=$(xrandr -q | grep -v "Screen ")
  local addResolutionToList=false
  local resolutions=""
  while IFS= read -r line
  do
    if [[ $(echo $line | grep $output) != "" ]]; then
        addResolutionToList=false
    fi
    if [[ "$addResolutionToList" = true ]]; then
      resolutions+=($(echo $line | awk '{print $1}' ))
    fi
    if [[ $(echo $line | grep "$output") != "" ]]; then
        addResolutionToList=true
    fi
  done <<< "$xrandrData"
  echo $resolutions
}