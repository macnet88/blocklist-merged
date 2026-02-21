#!/bin/sh

# URLs
HAGEZI_URL="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.plus.txt"
OISD_URL="https://big.oisd.nl"

# Temp files
HAGEZI="/tmp/hagezi.txt"
OISD="/tmp/oisd.txt"

# Output merged file
MERGED="/tmp/blocklist-merged.txt"

echo "Downloading lists..."
wget -qO "$HAGEZI" "$HAGEZI_URL"
wget -qO "$OISD" "$OISD_URL"

echo "Cleaning lists..."
sed 's/#.*//;/^\s*$/d' "$HAGEZI" > /tmp/hagezi.clean
sed 's/#.*//;/^\s*$/d' "$OISD" > /tmp/oisd.clean

echo "Merging and removing duplicates..."
cat /tmp/hagezi.clean /tmp/oisd.clean \
    | sort -u \
    > "$MERGED"

COUNT=$(wc -l < "$MERGED")

echo "Merged list saved to: $MERGED"
echo "Total unique domains: $COUNT"
