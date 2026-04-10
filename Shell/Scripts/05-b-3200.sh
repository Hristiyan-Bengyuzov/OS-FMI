#!/bin/bash

# Да се напише shell скрипт, който приканва потребителя да въведе пълното име на директория и извежда на стандартния изход подходящо съобщение за броя на всички файлове и всички директории в нея.

read -p 'Enter a directory: ' directory

if [[ ! -d "${directory}" ]]; then
    echo 'Not a valid directory' >&2
    exit 1
fi

files=$(find "${directory}" -mindepth 1 -type f 2>&1 | wc -l)
directories=$(find "${directory}" -mindepth 1 -type d 2>&1 | wc -l)

echo "Files count: ${files}"
echo "Directories count: ${directories}"