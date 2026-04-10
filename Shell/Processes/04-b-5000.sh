# Намерете колко физическа памет заемат всички процеси на потребителската група root.

ps -e -o rss=,group= | awk '$2 == "root" { sum += $1 } END { print sum }'
ps -e -g root -o rss= | awk '{ sum += $1 } END { print sum }'
