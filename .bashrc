DOTRC=/Users/nv/.dotrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

RED='\e[0;31m'
GREEN='\e[0;32m'
RD='\033[0;31m'

echo "maybe enable screen?"
echo

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:$(parse_git_branch)\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='$(test_ena)'${RED}'\$'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Grab zsh completion for bash
. /usr/local/git/contrib/completion/git-completion.bash

# Fetch alias definitions
echo "Locating base configuration.."
if [ -f ${DOTRC}/base.sh ]; then
    echo *base*
    . ${DOTRC}/base.sh
fi

# Named directories
code="/media/w7/Projects"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
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

#Nice Exports
export EDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export PATH="$PATH:$HOME/scripts" # include home-grown tools
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nonumber nolist' -c 'noremap q ZQ' \
    -c 'map <SPACE> <C-D>' -\" \
    "
    # Add this line above the above to remap K
    #-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"\
check=""
if [[ `hostname` == 'nv' ]]; then 
  # Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_26/";
  # Set Hadoop-related environment variables
  export HADOOP_HOME=/usr/local/hadoop
  # Now we can cd from anywhere
  export CDPATH="/media/w7/Projects/"
  export PATH="/home/nikos/.cabal/bin:$PATH"
  gnome-keyboard-properties &
  check=$!
  fbsetbg /media/w7/Users/nikos/Dbox/Dropbox/Photos/Wallpapers/aetherea.jpg
elif [[ `hostname` == 'cis555-vm' ]] ; then
  export PATH=$PATH:/home/cis555/555/.tools
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
  ### Run the following at least once in a session ###
#  xrandr --newmode "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
#  xrandr --addmode VBOX0 "1920x1080"
#  # xrandr -s 1920x1080
  # gnome-keyboard-properties &
  # check=$!
  # fbsetbg /media/w7/Users/nikos/Dbox/Dropbox/Photos/Wallpapers/aetherea.jpg
#  # fbsetbg ~/Downloads/1680x1050.jpg
#  # vim .inputrc
#  # mv X.defaults .Xdefaults
#  # vim .Xdefaults
#   xrandr --newmode "1280x800@60" 83.46 1280 1344 1480 1680 800 801 804 828
#   xrandr --addmode VBOX0 "1280x800@60"
#   xrandr -s 1280x800@60
  set meta-flag on
  set convert-meta off
  set output-meta on
  xrdb -load ~/.Xdefaults
fi;

# Adding export for KLEE in order to run
# *.cde files only by invoking their name
# TODO: ADD a lib folder in programs
if [[ -d  "$HOME/Programs/klee-cde-package/bin/" ]]; then
  export PATH=$HOME/Programs/klee-cde-package/bin/:$PATH;
fi

function vcs_status {
  if type -p __git_ps1; then
branch=$(__git_ps1)
  else
branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  fi
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
  local branch=$(__git_ps1 "%s")
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


# Set the screen title
case $TERM in
  screen*)
    # This is the escape sequence ESC k \w ESC \
    #Use path as titel
    #SCREENTITLE='\[\ek\w\e\\\]'
    #Use program name as titel
    # SCREENTITLE='\[\ek\w\e\\\]'
    SCREENTITLEPROCESS='\[\ek\e\\\]'
    ;;
  *)
    SCREENTITLE=''
    SCREENTITLEPROCESS=''
    ;;
esac

# PS1="${SCREENTITLEPROCESS}${SCREENTITLE}${PS1}"
PS1="${SCREENTITLEPROCESS}${SCREENTITLE}${PS1}"

function cd {
  builtin cd $* && ls
}

function mkd() {
  mkdir -p $* && cd $*
}

# Job control functions
function f {
  fg %$*
}

function b {
  bg %$*
}

function mem {
  echo "In use:\t\e[00;31m$(free | grep Mem | awk '{print $3/$2 * 100.0}')\e[00m\t%"
  echo "Free:\t\e[00;31m$(free | grep Mem | awk '{print $4/$2 * 100.0}')\e[00m\t%"
}
## TODO: IF ON FLUXBOX
# fbsetbg /media/w7/Users/nikos/Dbox/Dropbox/Photos/Wallpapers/aetherea.jpg
# gnome-keyboard-properties
# kill $check
alias breeze='/media/w7/Projects/UPenn/SAFE/SAFE/breeze/breeze-interpreter/src/dist/build/breeze/breeze'
