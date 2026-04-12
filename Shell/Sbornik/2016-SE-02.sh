#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
    echo 'Must be root to run this script' >&2
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo 'Expected one parameter - a number' >&2
    exit 2
fi

if [[ ! $1 =~ ^(0|[1-9][0-9]*)$ ]]; then
    echo 'Expected a positive number' >&2
    exit 3
fi

pids_to_kill=$(ps -e -o user=,pid=,rss= | awk -v bound="${1}" '
{
    rss_sum[$1] += $3
    if ($3 > max[$1]) {
        max[$1] = $3
        pid[$1] = $2
    }
}

END {
    for (u in rss_sum) {
        if (rss_sum[u] > bound) {
            print pid[u]
        }
    }
}
')

for pid in $pids_to_kill; do
    kill "${pid}" 2>/dev/null
    sleep 1
    kill -KILL "${pid}" 2>/dev/null
done