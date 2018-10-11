#!/bin/bash

# This script adds '.' at the beginning of all jpg files in the current directory (and its subfolders)
# -> invisible for users of linux file system
IFS=$'\n'
for file in $(find | grep ".*.jpg$"); do
  index=$(echo `expr match "$file" '.*/'`)
  new=${file:0:index}.${file:index}
  echo "renaming $file to $new"
  mv "$file" "$new"
done;
