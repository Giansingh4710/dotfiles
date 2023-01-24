#!/bin/bash


cd /Users/gians/Desktop/audios/Shiv/SDO || exit

tracksLen=$(ls -l | wc -l) #using ls -l gives me one more line, which is good when i do random

randNum=$(($RANDOM % $tracksLen))
echo $randNum

currInd=0
for track in *;do
  if [[ currInd -eq $randNum ]];then
    open "$track"
  fi
  ((currInd+=1))
done
