#!/bin/bash

# Да се напише shell скрипт, който приканва потребителя да въведе низ - потребителско име на потребител от системата - след което извежда на стандартния изход колко активни сесии има потребителят в момента.

read -p 'Enter username: ' username

if ! id "${username}" &>/dev/null; then
    echo "User ${username} not found." >&2
    exit 1
fi

active_sessions=$(who | grep -w "${username}" | wc -l)
echo "User ${username} has ${active_sessions} active sessions."