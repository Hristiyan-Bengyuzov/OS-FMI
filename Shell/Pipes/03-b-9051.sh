# Използвайки файл population.csv, намерете колко е общото население на света през 2008 година.
awk -F ',' '$3 == 2008 { population += $4 } END { print population }' ~/population.csv

# А през 2016?
awk -F ',' '$3 == 2016 { population += $4 } END { print population }' ~/population.csv