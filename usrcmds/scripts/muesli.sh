#!/bin/bash

# This script logs into muesli and greps the current points, saves them and outputs them on the console with vim.
if [[ ! $# -eq 2 ]]; then
  echo "Usage: muesli LECTURE-MÜSLI-WEBPAGE PATH_TO_SAVE"
  exit 1
fi
echo "--- This is muesli v1.0 ---"
echo "Please enter your login credentials for Müsli @ mathi.uni-heidelberg.de"
read -p "Email: " mail
read -s -p "Password: " pw
printf "\n"
# Initialize cookie jar
curl --silent --cookie-jar cjar --output /dev/null https://muesli.mathi.uni-heidelberg.de/user/login
# Login
curl --silent --cookie cjar --cookie-jar cjar --output /dev/null --data "email=$mail" --data "password=$pw" -o /dev/null -L https://muesli.mathi.uni-heidelberg.de/user/login
# Get the actual website and parse it
curl --silent --cookie cjar -L "$1" | grep -oE \
"Resultate für \w+(\s*\w*)*\
|[0-9]+\.[0-9]\/[0-9]+\.[0-9]\
|-\/[0-9]+\.[0-9]\
|Übungsblatt [0-9]+\
|Übungszettel [0-9]+\
|[0-9]+%\
|Insgesamt" > "$2"
rm cjar
echo "Opening vim to show results..."
vim "$2"
