#!/bin/bash

# Опишете поредица от команди или напишете shell скрипт, които/който при известни две директории SOURCE и DESTINATION:
# - намира уникалните "разширения" на всички файлове, намиращи се някъде под SOURCE.
# - за всяко "разширение" създава по една поддиректория на DESTINATION със същото име
# - разпределя спрямо "разширението" всички файлове от SOURCE в съответните поддиректории в DESTINATION

if [[ $# -ne 2 ]]; then
    echo 'Expected two arguments - source and destination directories' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'Source directory is invalid' >&2
    exit 2
fi

src=$1
dest=$2

mkdir -p "${dest}" &>/dev/null

while read file; do
    extension=$(echo "${file}" | awk -F '.' '{ print $NF }')
    mkdir -p "${dest}/${extension}" &>/dev/null
    cp "${file}" "${dest}/${extension}"
done < <(find "${src}" -type f 2>/dev/null)