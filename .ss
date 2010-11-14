#!/bin/bash
# Script to get run by hardstatus in screen.
# Prints customized single-line system stats
IP=`ifconfig eth0 | grep Mask | cut -d: -f2 | cut -d " " -f1`
UPTIME=`perl -pe 's/^(\d+).*/sprintf("%d", ($1\/(24*3600)))."ds"/e' /proc/uptime`
#echo -n "$IP|$UPTIME"
echo -n "$UPTIME|$IP"
