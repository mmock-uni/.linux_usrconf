#!/bin/bash

# This script downloads all given URLs via curl into the current directory
# or nothing if URL returns error 404: File not found
if [[ ! "$#" -gt 0 ]]; then
  echo "Usage: download URL1 URL2 ... URLN"
  exit 1
fi
while (( "$# ")); do
  echo "Downloading $1"
  curl -Of "$1"
  shift 1
done
