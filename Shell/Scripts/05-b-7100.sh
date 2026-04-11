#!/bin/bash

# Да се напише shell скрипт, който приема два параметъра - име на директория и число.
# Скриптът да извежда на стандартния изход имената на всички обикновени файлове във директорията, които имат размер, по-голям от подаденото число.

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'Expected first parameter to be a directory' >&2
    exit 2
fi

if [[ ! $2 =~ ^(0|[1-9][0-9]*)$ ]]; then
    echo 'Expected second argument to be a positive number' >&2
    exit 3
fi

dir=$1
size=$2

while read file; do
    echo "${file}"
done< <(find "${dir}" -type f -size +"${size}"c 2>/dev/null)