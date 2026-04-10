#!/bin/bash

# Имате компилируем (a.k.a няма синтактични грешки) source file на езика C. Напишете shell script, който да покaзва колко е дълбоко най-дълбокото nest-ване (влагане).
# Примерен .c файл:
#
# #include <stdio.h>
#
# int main(int argc, char *argv[]) {
#
#   if (argc == 1) {
#       printf("There is only 1 argument");
#   } else {
#       printf("There are more than 1 arguments");
#   }
#
#   return 0;
# }
# Тук влагането е 2, понеже имаме main блок, а вътре в него if блок.

if [[ $# -ne 1 ]]; then
    echo 'Expected 1 parameter' >&2
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo 'Expected a file' >&2
    exit 2
fi

max=0
curr=0

while read -n 1 ch; do
    if [[ "${ch}" == "{" ]]; then
        curr=$((curr + 1))

        if [[ curr -gt max ]]; then
            max=${curr}
        fi
    elif [[ "${ch}" == "}" ]]; then
        curr=$((curr - 1))
    fi
done < "$1"

echo "Max nesting depth: ${max}"