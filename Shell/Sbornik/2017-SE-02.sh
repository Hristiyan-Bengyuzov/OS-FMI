#!/bin/bash

if [[ $# -ne 3 ]]; then
    echo 'Expected 3 parameters' >&2
    exit 1
fi

if [[ ! -d $1 || ! -d $2 ]]; then
    echo 'First two parameters must be directories - src and dest' >&2
    exit 2
fi

src=$1
dest=$2
str=$3
files=$(find "${dest}" -mindepth 1 -type f | wc -l)

if [[ $files -ne 0 ]]; then
    echo 'Destination must be empty' >&2
    exit 3
fi

if [[ "$(whoami)" != "root" ]]; then
    echo 'Must be root to execute this script' >&2
    exit 4
fi

while read -r file; do
    new_path=$(echo "${file}" | sed -E "s:^${src}":${dest}:)
    new_dir=$(dirname "${new_path}")
    mkdir -p "${new_dir}" 2>/dev/null
    mv "${file}" "${new_path}" 2>/dev/null
done < <(find "${src}" -type f -name "*${str}*" 2>/dev/null)