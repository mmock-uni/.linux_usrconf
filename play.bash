play() {
  if [ $# -lt 1 ]; then
    echo "Usage: play REGEX [REGEX [...[REGEX]...]"
    return 1
  fi
  regex=""
  for a in "$@"; do
    regex+=".*$a"
  done
  findCmd="find /media/ekzyis/HDD/ekzyis/Musik -type f -iregex '$regex.*' ! -iregex '.*.\(pls\|ini\|jpg\|db\|ico\)'"
  eval "$findCmd"
  ( eval "$findCmd" -print0 | xargs -0 xplayer --enqueue > /dev/null 2>&1 & )
}
