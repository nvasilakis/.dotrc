# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. ~/.dotrc/shell/environment.sh
. ~/.dotrc/shell/functions.sh

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Autocomplete git aliases
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
      || complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git_add gga 
complete -o default -o nospace -F _git_commit ggc 
complete -o default -o nospace -F _git_checkout ggh 
complete -o default -o nospace -F _git_branch ggb 
complete -o default -o nospace -F _git_log ggl 
complete -o default -o nospace -F _git_diff ggd 
complete -o default -o nospace -F _git_push ggp

parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo '±'
}
parse_git_branch() {
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
}

# Custom key bindings
bind '"\C-xs": forward-search-history'
bind '"\C-xr": reverse-search-history'
bind '"\C-x\C-x": exchange-point-and-mark'
bind '"\M-w": copy-region-as-kill'

color='yes'
if [ "$color" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:$(parse_git_branch)\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

SCREENTITLE=''
SCREENTITLEPROCESS=''
# Set the screen title
case $TERM in
  screen*)
    # This is the escape sequence ESC k \w ESC \
    #Use path as titel
    SCREENTITLEPROCESS='\[\ek\e\\\]'
    ;;
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac
PS1="${SCREENTITLEPROCESS}${SCREENTITLE}${PS1}"
