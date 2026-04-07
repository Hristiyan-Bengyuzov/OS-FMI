# 1. Изведете GID-овете на 5-те най-големи групи спрямо броя потребители, за които
# съответната група е основна (primary).

# awk takes care of leading spaces
cut -d ':' -f 4 /etc/passwd | sort | uniq -c | sort -nr | head -n 5 | awk '{ print $2 }'

# otherwise we squeeze
cut -d ':' -f 4 /etc/passwd | sort | uniq -c | sort -nr | head -n 5 | tr -s ' ' | cut -d ' ' -f 3

# 2. (*) Изведете имената на съответните групи.

cut -d ':' -f 4 /etc/passwd | sort | uniq -c | sort -nr | head -n 5 | awk '{ print $2 }' | xargs -I{} grep ":{}:" /etc/group | cut -d ':' -f 1