############################################
# ~~~ IMPORT ALIASES FOR CONFIGURATION ~~~ #
############################################
export USRCONFPATH=~/.linux_usrconf

##############################
# ~~~ VIM STYLE COMMANDS ~~~ #
##############################

alias :q=exit
alias :r='. ~/.bashrc' # reinit usrconf
alias :R=':r'
alias :E=':e'

##############################################
# ~~~ FAST ACCESS to FILES / DIRECTORIES ~~~ #
##############################################

# cd to desktop
alias cdd='cd ~/Desktop'

# Fast access to usb sticks
alias cdm='cd /media/$USER/ && ls'

# Fast access to download dir
alias cddow='cd ~/Downloads && ls'

# Desktop variable
export ds=~/Desktop

# open bash configuration with vim
alias bashconf='vim ~/.bashrc'

alias up='up() { cd $(printf "%0.s../" $(seq 1 $1 )); };up'

###################################
# ~~~ FAST ACCESS to COMMANDS ~~~ #
###################################

alias ..='cd ..'

# copy dir to path
alias cpdir='cp -r'

# Standard opener for files
alias o='xdg-open 2> /dev/null'

# alias for showing files after cd
alias cdls='cdls() { cd "$1" && ls; }; cdls'

alias psg='ps -A | grep'

##################################
# ~~~ CHROMIUM / WEB ALIASES ~~~ #
##################################

# Open website with chromium in background and no shell output
chromium() {
  ( chromium-browser "$1" & ) > /dev/null 2>&1
  # redirects stdout to /dev/null and stderr to stdout
}
alias chr=chromium

# Google
alias google='chr https://google.com'
# Google Drive
alias gdrive='chr https://drive.google.com/drive/my-drive'
# GMail
alias mail='chr https://mail.google.com'
# Müsli
alias müsli='chr https://muesli.mathi.uni-heidelberg.de/user/login'
# Ricoh
alias ricoh='chr https://ricoh-eop.urz.uni-heidelberg.de/login.cfm?dest=index.cfm'
# Discord
alias discord='chr https://discordapp.com/channels/@me'
# Github
alias github='chr https://github.com/'
# YouTube
alias yt='chr https://www.youtube.com/'

##################################
# ~~~ ALIASES TO USE SCRIPTS ~~~ #
##################################

alias db='~/.linux_usrconf/bash_exclude/scripts/db.sh'
alias muesli.sh='~/.linux_usrconf/bash_exclude/scripts/muesli.sh'
alias download.sh='~/.linux_usrconf/bash_exclude/scripts/download.sh'
