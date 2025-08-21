#!/bin/bash

cd $(dirname "$0")

# Hide the cursor.
printf "\x1b[?25l"

while true; do
    ruby nankai.rb & PID=$!
    wait $PID
    sleep 2
done
