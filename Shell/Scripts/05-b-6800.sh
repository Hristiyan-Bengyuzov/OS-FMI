#!/bin/bash

# Да се напише shell скрипт, който получава единствен аргумент директория и отпечатва списък с всички файлове и директории в нея (без скритите).
# До името на всеки файл да седи размера му в байтове, а до името на всяка директория да седи броят на елементите в нея (общ брой на файловете и директориите, без скритите).
# a) Добавете параметър -a, който указва на скрипта да проверява и скритите файлове и директории. - no idea how to do this lol

if [[ $# -ne 1 ]]; then
    echo 'Expected one argument' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'Expected argument to be a directory' >&2
    exit 2
fi

dir=$1

while read file; do
    if [[ -f "${file}" ]]; then
        size=$(stat -c '%s' "${file}")
        echo "${file} (${size} bytes)"
    elif [[ -d "${file}" ]]; then
        entries=$(find "${file}" -mindepth 1 -maxdepth 1 2>/dev/null | wc -l)
        echo "${file} (${entries} entries)"
    fi
done< <(find "${dir}" -mindepth 1 2>/dev/null)