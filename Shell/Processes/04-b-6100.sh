# Изведете имената на потребителите, които имат поне 2 процеса, чиято команда е vim (независимо какви са аргументите й)

ps -e -o user=,comm= | awk '$2 == "vim" { count[$1]++ } END { for (u in count) if (count[u] >= 2) print u }'
ps -e -o user=,comm= | grep '\bvim\b' | sort | uniq -c | awk '$1 >= 2 { print $2 }'