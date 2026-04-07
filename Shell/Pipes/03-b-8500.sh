# За всяка група от /etc/group изпишете "Hello, <група>", като ако това е вашата група, напишете "Hello, <група> - I am here!".

awk -F ':' -v my_group_id=$(id -g) '{ print "Hello, " $1 ($3 == my_group_id ? " - I am here!" : "") }' /etc/group