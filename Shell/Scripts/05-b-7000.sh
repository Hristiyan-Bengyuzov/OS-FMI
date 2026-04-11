#!/bin/bash

# Да се напише shell скрипт, който приема произволен брой аргументи - имена на файлове.
# Скриптът да прочита от стандартния вход символен низ и за всеки от зададените файлове извежда по подходящ начин на стандартния изход броя на редовете, които съдържат низа.
# NB! Низът може да съдържа интервал.

for arg in "${@}"; do
    if [[ ! -f "${arg}" ]]; then
        echo "${arg} is not a file." >&2
        exit 1
    fi
done

read -p 'Enter a string to search for: ' search

for file in "${@}"; do
    rows=$(grep "${search}" "${file}" | wc -l)
    echo "${file} has ${rows} rows that contain the string"
done