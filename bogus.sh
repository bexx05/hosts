#!/bin/sh

# variabila cu diez e contor pentru command-line arguments, -gt 0 greater than 0, cu shift tai variabile
host = "$1"
address = "$2"
dns_server = "$3"
true_address = $(dig+short "$host" "@$dns_server" | tail -n1)
if [ -z "$true_address" ]; then
 echo "bogus ip for $host (not found using DNS server $dns_server)"
 return 1
fi
if [ "$address" = "$true_address" ]; then
 echo "IP address is ok"
 return 0
else
 echo "bogus ip for $host (not found using DNS server $dns_server)"
 return 1
 fi

