# Намерете само Group ID-то си от файлa /etc/passwd.

grep $(whoami) /etc/passwd | cut -d ':' -f 4
grep $(whoami) /etc/passwd | awk -F ':' '{ print $4 }'