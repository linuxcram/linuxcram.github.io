#!/bin/bash
curl -kLs https://debian.org | grep -e "<title>" | head -1
