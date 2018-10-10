# .linux_usrconf
To read in your personal configuration by bash, add this to your ~/.bashrc:
```shell
# _____________ USER _____________

SILENT_USRCONF_LOAD=1
# Read in user configuration which can be separated into different files (and subfolders)
if [[ -d ~/.linux_usrconf ]]; then
    (exit "$SILENT_USRCONF_LOAD") && echo "Loading ~/.linux_usrconf:"
    cd ~/.linux_usrconf
    for f in $(find)
    do
      if [[ ! -d "$f" && "${f:0:6}" != "./.git" && "$f" != "./README.md" && "${f:0:17}" != "./usrcmds/scripts" ]]; then
        (exit "$SILENT_USRCONF_LOAD") && echo "    > source ${f:2}"
        . "$f"
      fi
    done
    cd "$OLDPWD"
fi
```
Please notice that the repository needs to be located at ~/ for following reasons:
* the code above includes the statement `cd ~/.linux_usrconf`
* the scripts inside usrcmds/scripts/ are called via hardcoded paths. This means some files (like webfunc) have some hardcoded paths (like [this](https://github.com/ekzyis/.linux_usrconf/blob/8a0ec850efdad0bc4db50687b3a6e881a453c9e7/usrcmds/webfunc#L31)) in them to call those
