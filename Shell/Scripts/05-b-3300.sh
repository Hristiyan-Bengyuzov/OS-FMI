#!/bin/bash

# Да се напише shell скрипт, който чете от стандартния вход имената на 3 файла, обединява редовете на първите два (man paste), подрежда ги по азбучен ред и резултата записва в третия файл.

read -p 'Enter first file: ' f1
read -p 'Enter second file: ' f2
read -p 'Enter third file: ' f3

if [[ ! -f "${f1}" ]]; then
    echo 'Invalid first file!' >&2
    exit 1
fi

if [[ ! -f "${f2}" ]]; then
    echo 'Invalid second file!' >&2
    exit 2
fi

if [[ ! -f "${f3}" ]]; then
    echo 'Invalid third file!' >&2
    exit 3
fi

paste "${f1}" "${f2}" | sort > "${f3}"