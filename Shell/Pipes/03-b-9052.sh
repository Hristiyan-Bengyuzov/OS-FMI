# Използвайки файл population.csv, намерете през коя година в България има най-много население.

awk -F ',' '$2 == "BGR" && $4 > max_pop { max_year = $3; max_pop = $4 } END { print max_year }' ~/population.csv
grep 'BGR' ~/population.csv | sort -t ',' -k 4 -nr | head -n 1 | cut -d ',' -f 3