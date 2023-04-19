#!/bin/bash

#python3 ./code/gv.py ./  "https://gurmatveechar.com/audio.php?q=f&f=%2FGurbani_Ucharan%2FKabaal_Singh_%28Hazoor_Sahib_wale%29%2FSri_Dasam_Granth_Sahib_%28Hazoor_Sahib_Bir%29"
#python3 ./code/akjorg.py ./ "Bhai Harpreet Singh" "Giaan Singh"
#python3 ./code/goldenKhajan.py ./BobJones "http://sikhsoul.com/golden_khajana/index.php?q=f&f=%2FKeertan%2FBhai+Amolak+Singh"

PS3="Enter the Number: "  # for thr select loop. This will be the prompt
path=$1
if [ ! -d "$path" ];then
  path=$(pwd)
fi
printf "\nThe Diretory: %s\n\n" "$path"

MainDir=~/dotfiles/scripts/download_files
select opt in "GurmatVeechar" "AKJ.org" "GoldenKhajana" "YouTube/SoundCloud etc" "Get Length Of Audio Files" "Number Files";do 
  the_command=()
  if [[ $opt == "GurmatVeechar" ]];then
    echo "Enter links from GurmatVeechar.com separated by space: "
    read -r -a links
    the_command=(python3 "$MainDir/code/gv.py" "$path" "${links[*]}")
  elif [[ $opt == "AKJ.org" ]];then
    echo "Enter name of a Keertani: "
    read -r name
    the_command=(python3 "$MainDir/code/akjorg.py" "$path" "$name")
  elif [[ $opt == "GoldenKhajana" ]];then
    echo "Enter a link from Golden Khajan: "
    read -r link
    the_command=(python3 "$MainDir/code/goldenKhajan.py" "$path" "$link")
  elif [[ $opt == "YouTube/SoundCloud etc" ]];then
    echo "Enter a link for youtube-dl: "
    read -r link
    # youtube-dl --extract-audio --audio-format mp3 "$link"
    the_command=(yt-dlp --extract-audio -f 139 "$link")
  elif [[ $opt == "Get Length Of Audio Files" ]];then
    the_command=(python3 "$MainDir/code/len_of_files.py" "$path")
  elif [[ $opt == "Number Files" ]];then
    the_command=(python3 "$MainDir/code/number_files.py" "$path")
  fi
  echo "Executing:"
  echo "    ${the_command[*]}"
  "${the_command[@]}"

  exit
done

sleep 5

