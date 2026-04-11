#!/bin/bash

# Да се напише shell скрипт, който получава произволен брой аргументи файлове, които изтрива.
# Ако бъде подадена празна директория, тя бива изтрита. Ако подадения файл е директория с поне 1 файл, тя не се изтрива.
# За всеки изтрит файл (директория) скриптът добавя ред във log файл с подходящо съобщение.
#
# а) Името на log файла да се чете от shell environment променлива, която сте конфигурирали във вашия .bashrc.
# б) Добавете параметър -r на скрипта, който позволява да се изтриват непразни директории рекурсивно.
# в) Добавете timestamp на log съобщенията във формата: 2018-05-01 22:51:36

if [[ -z "${RMLOG_FILE}" ]]; then
    echo 'You need to setup an RMLOG_FILE environment variable' >&2
    exit 1
fi

recursive="false"

if [[ "${1}" == "-r" ]]; then
    recursive="true"
    shift
fi

for file in "${@}"; do
    timestamp=$(date +'%Y-%m-%d %H:%M:%S')

    if [[ -f "${file}" ]]; then
        rm "${file}"
        echo "[${timestamp}] Removed file ${file}" >> "${RMLOG_FILE}"
    elif [[ -d "${file}" ]]; then
        if [[ "${recursive}" == "true" ]]; then
            rm -rf "${file}"
            echo "[${timestamp}] Removed directory recursively ${file}" >> "${RMLOG_FILE}"
        elif rmdir "${file}" &>/dev/null; then
            echo "[${timestamp}] Removed directory ${file}" >> "${RMLOG_FILE}"
        fi
    fi
done