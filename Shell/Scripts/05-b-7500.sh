#!/bin/bash

# Напишете shell script guess, която си намисля число, което вие трябва да познате. В зависимост от вашия отговор,
# програмата трябва да ви казва "надолу" или "нагоре", докато не познате числото.
# Когато го познаете, програмата да ви казва с колко опита сте успели.
# Може да вземете a и b като параметри, но не забравяйте да направите проверката.

if [[ $# -ne 2 ]]; then
    echo 'Expected two parameters' >&2
    exit 1
fi

for arg in "${@}"; do
    if [[ ! "${arg}" =~ ^(0|-?[1-9][0-9]*)$ ]]; then
        echo "${arg} is not a number" >&2
        exit 2
    fi
done

if [[ $1 -gt $2 ]]; then
    echo 'Left bound cannot be bigger than right bound' >&2
    exit 3
fi

random_num=$(( RANDOM % ($2 - $1 + 1) + $1 ))
counter=0

while true; do
    counter=$((counter + 1))

    read -p 'Enter your guess: ' guess

    if [[ ! "${guess}" =~ ^(0|-?[1-9][0-9]*)$ ]]; then
        echo 'Your guess must be a number'
    elif [[ $guess -lt $random_num ]]; then
        echo 'Higher'
    elif [[ $guess -gt $random_num ]]; then
        echo 'Lower'
    else
        echo "RIGHT! Guessed ${random_num} in ${counter} tries."
        exit 0
    fi
done