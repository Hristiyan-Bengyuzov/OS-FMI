#!/bin/bash

# Да се напише shell скрипт, който форматира големи числа, за да са по-лесни за четене.
# Като пръв аргумент на скрипта се подава цяло число.
# Като втори незадължителен аргумент се подава разделител. По подразбиране цифрите се разделят с празен интервал.

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo 'Usage: <number> [separator]' >&2
    exit 1
fi

if [[ ! $1 =~ ^-?[0-9]+$ ]]; then
    echo "$1 is not a number" >&2
    exit 2
fi

sep=" "
num=$1
sign=""

if [[ $num =~ ^- ]]; then
    sign="-"
    num="${num:1}"
fi

if [[ $# -eq 2 ]]; then
    sep=$2
fi

res=""
count=0

while read -n 1 ch; do
    count=$((count + 1))
    res+="${ch}"

    if [[ $((count % 3)) -eq 0 ]]; then
        res+="${sep}"
    fi
done < <(echo -n "${num}" | rev)

res=$(echo -n "${res}" | rev)

# remove if there's a leading separator
res="${res#"${sep}"}"

res="${sign}${res}"

echo "${res}"