#!/bin/bash
# ipsweep script from HackerX app exercise

ip=$1

for host in $(seq 1 254);
do
	ping -c 1 $ip.$host | grep -i -e "64 bytes" | cut -d " " -f 4 | tr -d ":"
done
