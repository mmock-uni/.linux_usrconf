# .bash_usrconf
To read in your personal configuration by bash, enter this into your ~/.bashrc:

```shell
# _____________ USER _____________

# Read in user configuration which can be separated into different files (and subfolders)
if [ -d "$PATH_TO_THIS_REPOSITORY" ]; then
    echo "Loading $PATH_TO_THIS_REPOSITORY:"
    cd "$PATH_TO_THIS_REPOSITORY"
    for f in $(find)
    do
      if [ ! -d "$f" -a "${f:0:6}" != "./.git" -a "$f" != "./README.md" ]; then
        echo "    > source $f"
        . "$f"
      fi
    done
    cd "$OLDPWD"
fi
```
