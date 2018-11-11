# Change user configuration files which are indexed by find-command.
:e() {          
  cd "$USRCONFPATH"
  echo "Indexing files in dir $USRCONFPATH..."
  i=1
  findCmd="find . \( -path ./.git -o -path ./README.md \) -prune -o -type f -print"
  count=$(eval "$findCmd | wc -l")
  for f in $(eval "$findCmd"); do
    printf "%-$((${#count}+1))d %-10s\n" "$i" "${f:2}"
    i=$[i+1]
  done | column
  read -p "Which file do you want to edit? : " input
  # Check if input is valid
  regex="^-?[0-9]+$"
  if [[ ! "$input" =~ $regex ]]; then
    echo "Not a number."
    return 1
  fi
  if [[ "$input" -lt 1 || "$input" -gt "$count" ]]; then
    echo "Not a valid number."
    return 1
  fi
  # TODO This is not very efficient. Save lines in previous for-loop in an array
  # and access the files that way not by looping again.
  i=1
  for f in $(eval "$findCmd"); do
    if [[ "$i" == "$input" ]]; then
      cd "$OLDPWD"
      echo "running subl $USRCONFPATH/${f:2}"
      subl "$USRCONFPATH/${f:2}"
      return 0
    fi
    i=$[i+1]
  done
}
