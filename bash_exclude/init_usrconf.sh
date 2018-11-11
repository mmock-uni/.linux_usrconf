#!/bin/bash

# Initialize user configuration

BASHRC_CONFIG='
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
fi'
# Only write configuration lines when not already written
(grep -Pzoq '(?s)if \[\[ -d ~/\.linux_usrconf \]\].*for f in.*\. "\$f".*fi' ~/.bashrc && echo ".bashrc: already configured") \
|| (echo "$BASHRC_CONFIG" >> ~/.bashrc && echo ".bashrc: configuration successful")
# Copy rules for usage of Fido U2F security key
if [ ! -f /etc/udev/rules.d/70-u2f.rules ]; then
  if [ ! "$UID" -eq 0 ]; then
    echo "U2F: sudo required"
  else 
    sudo cp ~/.linux_usrconf/bash_exclude/70-u2f.rules /etc/udev/rules.d/ && echo "U2F: configuration successful"
  fi
else
  echo "U2F: already configured."
fi
# Automatically change sound input output
LOAD_ON_CONNECT="load-module module-switch-on-connect"
if [ -f /etc/pulse/default.pa ]; then
  grep -q "$LOAD_ON_CONNECT" /etc/pulse/default.pa && echo "pulseaudio: already configured with \`$LOAD_ON_CONNECT\`" || \
  if [ ! "$UID" -eq 0 ]; then
    echo "pulseaudio: sudo required"
  else
    sudo echo "load-module module-switch-on-connect" >> /etc/pulse/default.pa && echo "pulseaudio: configuration successful"
  fi
fi
# Add `xplayer --enqueue` command to context menu
cp ~/.linux_usrconf/bash_exclude/xplayer_enqueue.desktop ~/.local/share/applications
# Copy .gitconfig to home directory since that's where git is looking for it
cp ~/.linux_usrconf/bash_exclude/.gitconfig ~/
