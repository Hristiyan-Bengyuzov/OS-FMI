#!/bin/bash

# Да се напише shell script, който генерира HTML таблица съдържаща описание на
# потребителите във виртуалката ви. Таблицата трябва да има:
# - заглавен ред с имената нa колоните
# - колони за username, group, login shell, GECOS field (https://en.wikipedia.org/wiki/Gecos_field)

echo '<table>'
echo '  <tr>'
echo '    <th>Username</th>'
echo '    <th>group</th>'
echo '    <th>login shell</th>'
echo '    <th>GECOS</th>'
echo '  </tr>'

while IFS=: read -r username pass uid gid gecos home_dir login_shell; do
    group=$(grep ":${gid}:" /etc/group | cut -d ':' -f 1)

    echo '  <tr>'
    echo "    <td>${username}</td>"
    echo "    <td>${group}</td>"
    echo "    <td>${login_shell}</td>"
    echo "    <td>${gecos}</td>"
    echo '  </tr>'
done< /etc/passwd

echo '</table>'