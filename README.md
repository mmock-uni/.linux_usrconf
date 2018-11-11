# .linux_usrconf

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

To read in your personal configuration by bash, add this to your ~/.bashrc:
```shell
# _____________ USER _____________

SILENT_USRCONF_LOAD=1
# Read in user configuration which can be separated into different files (and subfolders)
if [[ -d ~/.linux_usrconf ]]; then
    (exit "$SILENT_USRCONF_LOAD") && echo "Loading ~/.linux_usrconf:"
    cd ~/.linux_usrconf
    for f in $(find . \( -path ./.git -o -path ./bash_exclude -o -name README.md \) -prune -o -type f -print )
    do
        (exit "$SILENT_USRCONF_LOAD") && echo "    > source ${f:2}"
        . "$f"
    done
    cd "$OLDPWD"
fi
```
or just execute the script */bash_exclude/init_usrconf.sh* (**This will configure everything, not only the terminal**) 

Please notice that the repository needs to be located at ~/ for following reasons:
* the code above includes the statement `cd ~/.linux_usrconf`
* the scripts inside bash_exclude/scripts/ are called via hardcoded paths. This means some files (like webfunc) have some hardcoded paths in them to call those
