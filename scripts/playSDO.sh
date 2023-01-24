#!/bin/bash


echo "Running: /Users/gians/dotfiles/scripts/playSDO.sh"

cd /Users/gians/Desktop/audios/SDO_files/yt_mga_SDO || exit

tracksLen=$(ls -l | wc -l) #using ls -l gives me one more line, which is good when i do random

randNum=$(($RANDOM % $tracksLen))

if [[ $1 ]];then
  randNum=$1
fi

echo "The Index: $randNum"

currInd=0
for track in *;do
  if [[ currInd -eq $randNum ]];then
    echo "$track"
    open "$track"
  fi
  ((currInd+=1))
done
