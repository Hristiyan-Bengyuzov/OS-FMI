#!/bin/bash

# Да се напише shell скрипт, който приема точно един параметър и проверява дали подаденият му параметър се състои само от букви и цифри.

if [[ $# -ne 1 ]]; then
    echo 'Expected 1 parameter' >&2
    exit 1
fi

if [[ ! $1 =~ ^[A-Za-z0-9]+$ ]]; then
    echo 'The input must only consist of letters and digits' >&2
    exit 2
fi

echo "Your parameter is: $1"