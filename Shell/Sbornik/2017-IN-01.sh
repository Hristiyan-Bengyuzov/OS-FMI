#!/bin/bash

if [[ $# -ne 3 ]]; then
    echo 'Expected three arguments' >&2
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo 'First argument must be a file' >&2
    exit 2
fi

file1=$(mktemp)
file2=$(mktemp)

grep -E "^${2}=" "${1}" | cut -d '=' -f 2 | tr ' ' '\n' | sort -u > "${file1}"
grep -E "^${3}=" "${1}" | cut -d '=' -f 2 | tr ' ' '\n' | sort -u > "${file2}"

res=$(comm -13 "${file1}" "${file2}" | tr '\n' ' ')

sed -i -E "s/^(${3}=).*/\1${res}/g" "${1}"

rm -f "${file1}"
rm -f "${file2}"