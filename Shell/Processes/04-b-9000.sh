# Да се отпечатат PID на всички процеси, които имат повече деца от родителския си процес.

ps -e -o pid=,ppid= | awk '{ parent[$1] = $2; children[$2]++ } END { for (p in parent) if (children[p] > children[parent[p]]) print p }'