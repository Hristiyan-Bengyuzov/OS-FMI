#!/bin/bash

# Да се напише shell скрипт, който валидира дали дадено цяло число попада в целочислен интервал.
# Скриптът приема 3 аргумента: числото, което трябва да се провери; лява граница на интервала; дясна граница на интервала.
# Скриптът да връща exit status:
# - 3, когато поне един от трите аргумента не е цяло число
# - 2, когато границите на интервала са обърнати
# - 1, когато числото не попада в интервала
# - 0, когато числото попада в интервала

if [[ $# -ne 3 ]]; then
    echo 'Expected 3 arguments' >&2
    exit 4
fi

for arg in "${@}"; do
    if [[ ! "${arg}" =~ ^-?[0-9]+$ ]]; then
        echo "${arg} is not a number" >&2
        exit 3
    fi
done

num=$1
left_bound=$2
right_bound=$3

if [[ $left_bound -gt $right_bound ]]; then
    echo 'Left bound is bigger than the right one' >&2
    exit 2
fi

if [[ $num -gt $left_bound && $num -lt $right_bound ]]; then
    echo 'Number is in range'
    exit 0
else
    echo 'Number is not in range' >&2
    exit 1
fi