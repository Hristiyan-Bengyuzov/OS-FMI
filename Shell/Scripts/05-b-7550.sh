#!/bin/bash

# Да се напише shell скрипт, който приема параметър - име на потребител.
# Скриптът да прекратява изпълненито на всички текущо работещи процеси на дадения потребител, и да извежда колко са били те.

if [[ $# -ne 1 ]]; then
    echo 'Expected one parameter' >&2
    exit 1
fi

if ! id "${1}" &>/dev/null; then
    echo "User ${1} not found" >&2
    exit 2
fi

process_count=$(ps -e -o user= | grep "${1}" | wc -l)

echo "User ${1} has ${process_count} processes."
pkill -u "${1}"