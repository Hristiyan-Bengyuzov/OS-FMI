#!/bin/bash

# Напишете shell script, който да приема параметър име на директория, от която взимаме файлове, и опционално експлицитно име на директория, в която ще копираме файлове. Скриптът да копира файловете със съдъ

if [[ $# -lt 1 ]]; then
    echo 'Expected at least 1 parameter' >&2
    exit 1
fi

if [[ $# -gt 2 ]]; then
    echo 'Expected 2 or less parameters' >&2
    exit 2
fi

if [[ ! -d $1 ]]; then
    echo 'First parameter not a directory' >&2
    exit 3
fi

src="$1"

if [[ $# -eq 2 ]]; then
    dest="$2"
else
    dest=$(date -I)
fi

mkdir -p "${dest}"

find "${src}" -mindepth 1 -maxdepth 1 -type f -mmin -45 | xargs -I{} cp "{}" "${dest}"
tar -cf "${dest}.tar.gz" "${dest}"