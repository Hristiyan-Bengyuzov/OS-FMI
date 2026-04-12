#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'First parameter must be a directory' >&2
    exit 2
fi

dir=$1
arch=$2
versions=$(mktemp)

while read -r file; do
    name=$(basename "${file}")

    if [[ "${name}" =~ ^vmlinuz-[0-9]+\.[0-9]+\.[0-9]+-${arch}$ ]]; then
        echo "${name}" >> "${versions}"
    fi
done < <(find "${dir}" -maxdepth 1 -type f 2>/dev/null)

latest=$(sort -Vr "${versions}" | head -n 1)
echo "${latest}"

rm -f "${versions}"