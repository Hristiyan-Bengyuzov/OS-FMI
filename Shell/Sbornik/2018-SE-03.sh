#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters' >&2
    exit 1
fi

if [[ ! -f "${1}" ]]; then
    echo 'First parameter must be a file' >&2
    exit 2
fi

if [[ ! -r "${1}" ]]; then
    echo 'First parameter must be a readable file' >&2
    exit 3
fi

if [[ ! "${1}" =~ ^.*\.csv$ || ! "${2}" =~ ^.*\.csv$ ]]; then
    echo 'Both parameters should have .csv extension' >&2
    exit 4
fi

awk -F ',' '
{
    key = ""
    for (i = 2; i <= NF; i++) {
        if (i > 2) {
            key = key ","
        }

        key = key $i
    }

    if (!(key in min_id) || $1 < min_id[key]) {
        min_id[key] = $1
        res[key] = $0
    }
}

END {
    for (k in res) {
        print res[k]
    }
}
' "${1}" > "${2}"