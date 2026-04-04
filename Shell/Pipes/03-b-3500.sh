# Колко файлове в /bin са 'shell script'-oве? 

find /bin/ -type f | xargs file | grep 'shell script' | wc -l
file /bin/* | grep 'shell script' | wc -l

# Колко файлове в дадена директория са ASCII text?

find /bin/ -type f | xargs file | grep 'ASCII text executable' | wc -l
file /bin/* | grep 'ASCII text executable' | wc -l