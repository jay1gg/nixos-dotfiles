#!/usr/bin/env bash
# /* ---- 💫 https://github.com/jay1gg 💫 ---- */  ##

# For Hyprlock
#pidof hyprlock || hyprlock -q

# Ensure weather cache is up-to-date before locking (Waybar/lockscreen readers)

#disable weather
# bash "$HOME/.config/hypr/UserScripts/WeatherWrap.sh" >/dev/null 2>&1

loginctl lock-session

