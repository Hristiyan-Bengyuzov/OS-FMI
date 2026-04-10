#!/bin/bash

# Да се напише shell скрипт, който чете от стандартния вход име на файл и символен низ, проверява дали низа се съдържа във файла и извежда на стандартния изход кода на завършване на командата с която сте пр
# NB! Символният низ може да съдържа интервал (' ') в себе си.

read -p 'Enter file name: ' file
read -p 'Enter search word: ' search

if [[ ! -f "${file}" ]]; then
    echo 'Invalid file' >&2
    exit 1
fi

grep -q "${search}" "${file}"
echo "Status code: $?"