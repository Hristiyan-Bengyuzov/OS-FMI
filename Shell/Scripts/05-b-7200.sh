#!/bin/bash

# Да се напише shell скрипт, който приема произволен брой аргументи - имена на файлове или директории. Скриптът да извежда за всеки аргумент подходящо съобщение:
#   - дали е файл, който може да прочетем
#   - ако е директория - имената на файловете в нея, които имат размер, по-малък от броя на файловете в директорията.

for arg in "${@}"; do
    if [[ -f "${arg}" ]]; then
        if [[ -r "${arg}" ]]; then
            echo "${arg} is a readable file."
        else
            echo "${arg} is not a readable file."
        fi
    elif [[ -d "${arg}" ]]; then
        files_count=$(find "${arg}" -maxdepth 1 -type f 2>/dev/null | wc -l)

        echo "${arg} is a directory."
        echo "Files in ${arg} with smaller size than the amount of files in it: "
        find "${arg}" -maxdepth 1 -type f -size -"${files_count}"c 2>/dev/null
    else
        echo "${arg} is not a file or directory"
    fi
done