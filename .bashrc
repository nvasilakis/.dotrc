# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo -n "Loading environment."
. ~/.dotrc/shell/environment.sh
echo ".OK"
echo -n "Loading base configuration.."
. ${DOTRC}/shell/base.sh
echo ".OK"
echo -n "Loading shell functions.."
. ${DOTRC}/shell/functions.sh
echo ".OK"
echo -n "Loading git completion.."
. /usr/local/git/contrib/completion/git-completion.bash
echo ".OK"
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

function vcs_status {
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  if [ $branch ]; then
    # no changes
    color="${txtpur}"
    status=$(git status --porcelain 2> /dev/null)
    # Untracked files (Green)
    if $(echo "$status" | grep '?? ' &> /dev/null); then
      echo -n "\033[1;32m☨"
    fi
    # Stashed changes (Purple)
    if $(echo "$status" | grep '^A ' &> /dev/null); then
      echo -n "\033[1;35m☀"
    fi
    # Modified files (Cyan)
    if $(echo "$status" | grep '^ M ' &> /dev/null); then
      echo -n "\033[1;36m❇"
    fi
    # Deleted filed (Red)
    if $(echo "$status" | grep '^ D ' &> /dev/null); then
      echo -n "\033[1;31m☢"
    fi
  fi
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo '±'
}
function parse_git_branch {
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
}

function help {
  if [[ "$1" == "gz" ]]; then
    echo '[-]->: tar xzvf < >.tar.gz [-C wh/er/e]'
    echo '[<]--: tar czvf < >.tar.gz /dir/'
  elif [[ "$1" == "bz" ]]; then
    echo '[-]->: tar xjvf < >.tar.bz2 [-C wh/er/e]'
    echo '[<]--: tar cjvf < >.tar.bz2 /dir/'
  elif [[ "$1" == "7z" ]]; then
    echo '[-]->: 7z a -t7z < >.7z'
    echo '[<]--: 7z x      < >.7z   /dir/'
  fi
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
export PATH="$PATH:/Users/nvasilakis/.local/bin" # andromeda node
