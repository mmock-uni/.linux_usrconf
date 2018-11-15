play() {
  if [ $# -lt 1 ]; then
    echo "Usage: play REGEX [REGEX [...[REGEX]...]"
    return 1
  fi
  regex=""
  for a in "$@"; do
    regex+=".*$a"
  done
  ( find /media/ekzyis/HDD/ekzyis/Musik -iregex ".*\(pls\|ini\|jpg\|db\)$" -prune -o -iregex "$regex.*" -print0 | xargs -0 xplayer --enqueue > /dev/null 2>&1 & )
}
