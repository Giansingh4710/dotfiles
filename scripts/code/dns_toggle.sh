#!/bin/bash

# Get the current DNS servers for Wi-Fi
current_dns=$(networksetup -getdnsservers Wi-Fi)

# Check if the current DNS is set to your custom server
if [[ "$current_dns" == "192.168.1.2" ]]; then
    echo "Switching to default DNS..."
    networksetup -setdnsservers Wi-Fi empty
    echo "DNS switched to default (automatic)."
else
    echo "Switching to custom DNS (192.168.1.2)..."
    networksetup -setdnsservers Wi-Fi 192.168.1.2
    echo "DNS switched to custom (192.168.1.2)."
fi
