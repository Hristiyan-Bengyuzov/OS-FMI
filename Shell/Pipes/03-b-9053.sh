# Използвайки файл population.csv, намерете коя държава има най-много население през 2016.
awk -F ',' '$3 == 2016' ~/population.csv | sort -t ',' -k 4 -nr | head -n 1 | cut -d ',' -f 1
awk -F ',' '$3 == 2016 && $4 > pop { pop = $4; country = $1 } END { print country }' ~/population.csv

# А коя е с най-малко население?
awk -F ',' '$3 == 2016' ~/population.csv | sort -t ',' -k 4 -n | head -n 1 | cut -d ',' -f 1
awk -F ',' '$3 == 2016 && (!pop || $4 < pop) { pop = $4; country = $1 } END { print country }' ~/population.csv