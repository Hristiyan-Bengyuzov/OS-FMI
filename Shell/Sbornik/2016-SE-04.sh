#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters - numbers' >&2
    exit 1
fi

for arg in $*; do
    if [[ ! "${arg}" =~ ^(0|-?[1-9][0-9]*)$ ]]; then
        echo "${arg} is not a valid number" >&2
        exit 2
    fi
done

mkdir -p {a..c} 2>/dev/null

while IFS= read -r file; do
    lines=$(cat "${file}" | wc -l)

    if [[ $lines -lt $1 ]]; then
        mv "${file}" a/
    elif [[ $lines -ge $1 && $lines -le $2 ]]; then
        mv "${file}" b/
    else
        mv "${file}" c/
    fi
done < <(find . -maxdepth 1 -type f 2>/dev/null)