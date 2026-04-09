# Да се преброят/изведат само песните на Beatles и Pink.

find ~/songs -mindepth 1 -printf '%f\n' | awk -F ' - ' '$1 == "Pink" || $1 == "Beatles"'
find ~/songs -mindepth 1 -printf '%f\n' | awk -F ' - ' '$1 == "Pink" || $1 == "Beatles"' | wc -l