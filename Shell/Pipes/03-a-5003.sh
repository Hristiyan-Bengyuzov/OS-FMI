# Изведете имената на хората с второ име по-късо от 8 (<=7) символа според /etc/passwd // !(>7) = ?

cat /etc/passwd | cut -d ':' -f 5 | cut -d ' ' -f 2 | cut -d ',' -f 1 | grep -E '[^a-zA-Z-]' | grep -E -v '.{8,}'