#!/bin/bash

CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_"
LENGTH=12

# Use /dev/urandom to generate random bytes, then base64 encode and select only specified characters
PASSWORD=$(LC_ALL=C tr -dc "$CHARS" < /dev/urandom | head -c $LENGTH)
echo "Copied Random Password: $PASSWORD"
echo "$PASSWORD" | pbcopy
