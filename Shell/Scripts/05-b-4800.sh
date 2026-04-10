#!/bin/bash

# Да се напише shell скрипт, който приема файл и директория. Скриптът проверява в подадената директория и нейните под-директории дали съществува копие на подадения файл и отпечатва имената на намерените коп
# NB! Под 'копие' разбираме файл със същото съдържание.

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters - a file and a directory' >&2
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo 'Expected first parameter to be a file' >&2
    exit 2
fi

if [[ ! -d $2 ]]; then
    echo 'Expected second parameter to be a directory' >&2
    exit 3
fi

found="false"
searched_file="${1}"
dir="${2}"

while read file; do
    if cmp -s "${file}" "${searched_file}"; then
        echo "${file}"
        found="true"
    fi
done< <(find "${dir}" -type f 2>/dev/null)

if [[ "${found}" == "false" ]]; then
    echo 'No copies found' >&2
    exit 4
fi