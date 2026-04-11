#!/bin/bash

# Напишете shell script, който получава като единствен аргумент име на потребител и за всеки негов процес изписва съобщение за съотношението на RSS към VSZ.
# Съобщенията да са сортирани, като процесите с най-много заета виртуална памет са най-отгоре.

if [[ $# -ne 1 ]]; then
    echo 'Expected one argument' >&2
    exit 1
fi

if ! id "${1}" &>/dev/null; then
    echo "User ${1} not found" >&2
    exit 2
fi

ps -e -o user=,rss=,vsz= --sort=-vsz |
awk -v username="${1}" '$1 == username { print "RSS to VSZ ratio: " $2 / $3 }'