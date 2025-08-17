#!/usr/bin/env bash
#
# curl-monitor.sh
# Continuously curl an endpoint and log timestamp + response code
#

URL="$1"
INTERVAL=1
COUNT="$2"

if [[ -z "$URL" ]]; then
  echo "Usage: $0 <url> [count]"
  exit 1
fi

i=0
while true; do
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  echo "[$TIMESTAMP] $STATUS_CODE"

  i=$((i+1))
  if [[ -n "$COUNT" && "$i" -ge "$COUNT" ]]; then
    break
  fi

  sleep "$INTERVAL"
done
