# Да се изведат всички албуми, сортирани по година.

find ~/songs -mindepth 1 | cut -d '(' -f 2 | cut -d ')' -f 1 | sort -t ',' -k 2 -nu | cut -d ',' -f 1