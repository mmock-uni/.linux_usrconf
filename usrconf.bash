# User configuration
usrconfpath=~/.linux_usrconf
usrconf() {
  __reinit() {
    . ~/.bashrc
  }
  OPTIND=1
  while getopts ":r-:" opt
  do
    case "$opt" in
      "-")  # check for long parameters
        case "$OPTARG" in
          reinit) __reinit; return 0;;
          *) echo "usrconf: Ungültige Option -- $OPTARG"; return 1;;
        esac;;
      r) __reinit; return 0;;
      *) echo "usrconf: Ungültige Option -- $OPTARG"; return 1;;
    esac
  done
  cd "$usrconfpath"
  unset -f __reinit # remove __reinit function since it is not intended to use outside of this function
}
