#!/bin/bash
echo "debian.org"
curl -kLs debian.org | grep -e "<title>" | head -1 | sed 's/<title>//g' | sed 's/<\/title>//g'
