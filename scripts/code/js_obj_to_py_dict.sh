#!/bin/bash

text=$(pbpaste)
echo "const obj=$text; console.log(JSON.stringify(obj, null, 2)); " | node | pbcopy
echo "Copied to clipboard"
