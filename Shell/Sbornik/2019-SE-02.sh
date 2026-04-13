#!/bin/bash

n=10

if [[ "${1}" == "-n" ]]; then
    if [[ ! "${2}" =~ ^(0|[1-9][0-9]*)$ ]]; then
        echo 'Expected a positive number for the -n option' >&2
        exit 1
    fi

    n=$2
    shift 2
fi

temp=$(mktemp)

for file in $@; do
    idf=$(basename -s '.log' "${file}")

    while read -r line; do
        timestamp=$(echo "${line}" | cut -d ' ' -f 1,2)
        data=$(echo "${line}" | cut -d ' ' -f 3-)
        echo "${timestamp} ${idf} ${data}" >> "${temp}"
    done < <(cat "${file}" | tail -n $n)
done

cat "${temp}" | sort -k 1,2

rm -f "${temp}