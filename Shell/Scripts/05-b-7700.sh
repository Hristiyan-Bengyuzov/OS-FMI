#!/bin/bash

# Да се напише shell скрипт, който приема два параметъра - име на директория и число.
# Скриптът да извежда сумата от размерите на файловете в директорията, които имат размер, по-голям от подаденото число.

if [[ $# -ne 2 ]]; then
    echo 'Expected two arguments' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'First argument should be a directory' >&2
    exit 2
fi

if [[ ! "${2}" =~ ^(0|[1-9][0-9]*)$ ]]; then
    echo 'Second argument should be a positive number' >&2
    exit 3
fi

dir=$1
num=$2

find "${dir}" -maxdepth 1 -type f -size +"${num}"c -printf '%s %f\n' 2>/dev/null |
awk '{ sum += $1 } END { print sum }'