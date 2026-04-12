#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo 'Expected one argument' >&2
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "${1} is not a file" >&2
    exit 2
fi

sed -E 's/^[0-9]+ г\. -//' "${1}" |
awk '{ print NR "." $0 }' |
sort -t '.' -k 2