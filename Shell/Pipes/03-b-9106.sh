# Да се направят директории с имената на уникалните групи. За улеснение, имената
# от две думи да се напишат слято:
# Beatles, PinkFloyd, Madness

find ~/songs -mindepth 1 -printf '%f\n' | cut -d '-' -f 1 | tr -d ' ' | sort -u | xargs -I{} mkdir -p ~/{}