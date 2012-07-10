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

# enable color support of ls and also add handy aliases
if [[ `uname` == 'Linux' ]]; then 
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
  # Less Colors for Man Pages
  # export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  # export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  # export LESS_TERMCAP_me=$'\E[0m'           # end mode
  # export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  # export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
  # export LESS_TERMCAP_ue=$'\E[0m'           # end underline
  # export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
else 
  export CLICOLOR=1
  #export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:
  alias ls='ls -G'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs -l'
alias f='fg'
alias b='bg'
alias ai='sudo apt-get install'
alias au='sudo apt-get update'
alias vim='vim -p'
alias gga='git add'
alias ggc='git commit -v'
alias ggh='git checkout'
alias ggb='git branch'
alias ggs='git status -sb'
alias ggl='git log --graph --decorate --oneline'
alias ggd='git diff --word-diff'
alias ggp='git push'
alias mam='nv@150.140.90.86'
alias etp='etp@150.140.91.13'
alias is='root@vasilak.is'
alias rseas='rdesktop vlab-rdp.seas.upenn.edu'
alias emacs='emacs -nw'
# A trick for faster nautilus
alias here='nautilus --no-desktop --browser .'
alias dbox="/media/w7/Documents\ and\ Settings/nikos/Dbox/Dropbox/"
# Instead of adding something to /usr/bin
alias idea="/media/w7/Projects/idea/bin/idea.sh"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
export CDPATH="/media/w7/Projects/"
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nonumber nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \
    "
    # Add this line above the above to remap K
    #-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"\

if [[ `hostname` == 'nv' ]]; then 
  # Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_26/";
  # Set Hadoop-related environment variables
  export HADOOP_HOME=/usr/local/hadoop
  # Now we can cd from anywhere
  export CDPATH="/media/w7/Projects/"
elif [[ `hostname` == 'cis555-vm' ]] ; then
  export PATH=$PATH:/home/cis555/555/.tools
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
  ### Run the following at least once in a session ###
#  xrandr --newmode "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
#  xrandr --addmode VBOX0 "1920x1080"
#  # xrandr -s 1920x1080
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

# Custom key bindings
bind '"\C-xs": forward-search-history'
bind '"\C-xr": reverse-search-history'
bind '"\C-x\C-x": exchange-point-and-mark'
bind '"\M-w": copy-region-as-kill'
