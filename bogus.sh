#!/bin/sh

while IFS= read -r line; do
    echo "$line" | grep -qE '^[[:space:]]*#|^[[:space:]]*$' && continue
    ip=$(echo "$line" | awk '{print $1}')
    host=$(echo "$line" | awk '{print $2}')
    [ -z "$ip" ] || [ -z "$host" ] && continue
    echo "$ip" | grep -qE '^127\.|^::1' && continue
    true_address=$(dig +short "$host" | tail -n1)
    [ -z "$true_address" ] && echo "Bogus IP for $host (not found)" && continue
    if [ "$ip" = "$true_address" ]; then
        echo "IP address is OK for $host"
    else
        echo "Bogus IP for $host (expected $true_address, got $ip)"
    fi
done < /etc/hosts
