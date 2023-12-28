#!/bin/bash


message=$1
title=$2
subtitle=$3

# /usr/bin/osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\" "
/usr/bin/osascript -e "display dialog \"$message\" with title \"$title\""
# /usr/bin/osascript -e 'set volume alert volume 75'

