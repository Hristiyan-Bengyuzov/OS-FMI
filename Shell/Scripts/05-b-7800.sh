#!/bin/bash

# Да се напише shell скрипт, който намира броя на изпълнимите файлове в PATH.
# Hint: Предполага се, че няма спейсове в имената на директориите
# Hint2: Ако все пак искаме да се справим с този случай, да се разгледа IFS променливата и констуркцията while read -d

count=0

while read -r -d ':' dir; do
    executable_count=$(find "${dir}" -maxdepth 1 -type f -executable 2>/dev/null | wc -l)
    count=$((count + executable_count))
done<<<"${PATH}"

echo "Executable files: ${count}"