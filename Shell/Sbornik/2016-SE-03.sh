#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
    echo 'Must be root to execute the script' >&2
    exit 1
fi

while IFS=: read -r user home_dir; do
    if [[ ! -d "${home_dir}" ]]; then
        echo "${home_dir} of ${user} is not a valid directory"
    elif [[ ! -w "${home_dir}" ]]; then
        echo "User ${user} can't write to ${home_dir}" 
    fi
done < <(cut -d ':' -f 1,6 /etc/passwd)