#!/usr/bin/env bash

AIRVPN_API_URL="https://airvpn.org/api/status/?key=$AIRVPN_API_KEY"
IPV="$1"
AIRVPN_LIST="airvpn_remote_ips_v$IPV.txt"

if [ -z "$IPV" ]; then
  echo "Error! No argument provided"
  echo "Use ip version 4 or 6"
  exit 0
fi

if [ -f "$AIRVPN_LIST" ]; then
  rm "$AIRVPN_LIST"
fi

AIRVPN_RESULT=$(curl -s "$AIRVPN_API_URL" | jq -r '.servers[]')

for i in 1 2 3 4; do
echo "$AIRVPN_RESULT" | jq -r '.ip_v'"$IPV"'_in'$i'' >> "$AIRVPN_LIST"
done
