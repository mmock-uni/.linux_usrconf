# Interactive cd
cdi() {
  dirs=()
  GREEN='\033[1;32m'
  NC='\033[0m' # No Color
  RED='\033[1;31m'
  count=1
  for l in $(ls -a --group-directories-first); do
    # only write directories to terminal
    if [[ -d "$l" ]]; then
      if [[ "$l" != "." ]]; then
        dirs+=("$l")
        count=$[count+1]
      fi
    else
      # due to `--group-directories-first` we can break after first non-dir
      break
    fi
  done
  i=1
  printf "You are in directory: ${GREEN}$PWD${NC}\n"
  for d in "${dirs[@]}"; do
    # $(($number_of_digits_of_dircount+1)):
    # -> needed space between index and dirname for pretty printing
    printf "%-$((${#count}+1))d %-10s\n" "${i}" "${d}"
    i=$[i+1]
  done | column
  printf "${RED}Press 'c' or 'ENTER' to cancel${NC}\n"
  read -p "cd to index: " input
  # Check for cancel value
  if [[ "$input" == "" || "$input" == "c" ]]; then
    return 0
  fi
  # Check if input is valid
  regex="^-?[0-9]+$"
  if [[ ! "$input" =~ $regex ]]; then
    echo "Not a number."
    return 1
  fi
  if [[ "$input" -lt 1 || "$input" -gt "$[count-1]" ]]; then
    echo "Not a valid number."
    return 1
  fi
  # Add 1 to input since '.' is first output of ls and we did skip it
  cd $(ls -a --group-directories-first | head -$[input+1] | tail -1)
  # Rerun function because user may want to cd further
  cdi
}
