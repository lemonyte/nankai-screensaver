#!/bin/bash

while true; do

    while true; do
        IDLE_TIME=$(dbus-send --print-reply --dest=org.gnome.Mutter.IdleMonitor /org/gnome/Mutter/IdleMonitor/Core org.gnome.Mutter.IdleMonitor.GetIdletime | awk 'END{print $NF}')
        if [[ $IDLE_TIME -ge $((${2:-300} * 1000)) ]]; then
            break
        fi
        sleep 1
    done

    ghostty --fullscreen=true -e "sleep 2 && bash $1" & SS_PID=$!

    dbus-monitor --session "type=signal,interface=org.gnome.SessionManager.Presence,member=StatusChanged" |
        while read x; do
            case "$x" in
                *"uint32 3"*)
                    sleep 5 && kill $SS_PID
                    break;;
                *"uint32 0"*)
                    sleep 5 && kill $SS_PID
                    break;;
            esac
        done &

    while true; do
        CURRENT_IDLE_TIME=`dbus-send --print-reply --dest=org.gnome.Mutter.IdleMonitor /org/gnome/Mutter/IdleMonitor/Core org.gnome.Mutter.IdleMonitor.GetIdletime | awk 'END{print $NF}'`
        if [[ $CURRENT_IDLE_TIME -lt $IDLE_TIME ]]; then
            kill $SS_PID
            break
        fi
        sleep 1
    done &

    wait $SS_PID
    pkill -P $$

done
