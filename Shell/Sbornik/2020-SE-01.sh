#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo 'Expecter two parameters - csv file and directory' >&2
    exit 1
fi

if [[ ! -d "${2}" ]]; then
    echo 'Not a directory' >&2
    exit 2
fi

if [[ ! "${1}" =~ ^.*\.csv$ ]]; then
    echo 'File must be in csv format' >&2
    exit 3
fi

echo 'hostname,phy,vlans,hosts,failover,VPN-3DES-AES,peers,VLAN Trunk Ports,license,SN,key' >> "${1}"

while read -r file; do
    hostname=$(basename -s '.log' "${file}")

    awk '
    {
        gsub(/ +/, " ")
        sub(/^ /, "")
        sub(/ $/, "")
        print $0
    }
    ' "${file}" |
    awk -F ': ' -v host="${hostname}" '
    /^Maximum Physical Interfaces/ { psy = $2 }
    /^VLANs/ { vlan = $2 }
    /^Inside Hosts/ { inside = $2 }
    /^Failover/ { fail = $2 }
    /^VPN-3DES-AES/ { vpn = $2 }
    /^\*Total VPN Peers/ { peers = $2 }
    /^VLAN Trunk Ports/ { ports = $2 }
    /^This platform/ {
        sub(/^This platform has an? /, "")
        sub(/ license\./, "")
        license = $0
    }
    /^Serial Number/ { sn = $2 }
    /^Running Activation Key/ { key = $2 }

    END {
        print host "," psy "," vlan "," inside "," fail "," vpn "," peers "," ports "," license "," sn "," key
    }
    ' >> "${1}"
done < <(find "${2}" -type f -name '*.log' 2>/dev/null)