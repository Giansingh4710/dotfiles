#!/bin/bash


message=$1
title=$2
subtitle=$3
/usr/bin/osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\" "

