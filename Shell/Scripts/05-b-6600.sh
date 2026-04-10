#!/bin/bash

# Да се напише shell скрипт, който получава единствен аргумент директория и изтрива всички повтарящи се (по съдържание) файлове в дадената директория.
# Когато има няколко еднакви файла, да се остави само този, чието име е лексикографски преди имената на останалите дублирани файлове.

if [[ $# -ne 1 ]]; then
    echo 'Expected one argument' >&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo 'Argument must be a directory' >&2
    exit 2
fi

dir="${1}"

while read f1; do
    if [[ ! -f "${f1}" ]]; then
        continue
    fi


    while read f2; do
        if [[ ! -f "${f2}" || "${f1}" == "${f2}" ]]; then
            continue
        fi


        if cmp -s "${f1}" "${f2}"; then
            if [[ "${f1}" < "${f2}" ]]; then
                rm "${f2}"
            else
                rm "${f1}"
                break
            fi
        fi
    done< <(find "${dir}" -type f 2>/dev/null)
done< <(find "${dir}" -type f 2>/dev/null)