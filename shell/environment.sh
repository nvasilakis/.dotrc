DOTRC=~/.dotrc

#Nice Exports
export EDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export PATH="$PATH:$HOME/scripts" # include home-grown tools
export LACONIC="false"

## My own man page viewer. If I need to remap K, add also:
#-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"\
## or
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod modified nonumber nolist autoread' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nonumber nolist' -c 'noremap q ZQ' \
  -c 'map <SPACE> <C-D>' -\" \
  "

HOSTNAME=`hostname`
if [[ `uname` == 'Linux' ]]; then
  # OCaml
  . /home/$(whoami)/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  # emacs on Gnome
  alias emacs='XLIB_SKIP_ARGB_VISUALS=1 emacs'
else
  # Haskell
  export PATH="$PATH:/Users/$(whoami)/Library/Haskell/bin"
  export PATH="/usr/local/bin:$PATH"
  export PATH="$PATH:/Library/TeX/texbin/"
  # Java
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home"
fi

lab=$HOME/lab

# Andromeda
androdev=$lab/universe
andromeda=$lab/universe/andromeda
alias andromeda="node $andromeda/andromeda.js"

# DCP
dcp=$lab/dcp
alias lh="http://localhost:8000/"
l="http://localhost:8000/"

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export PATH="$PATH:$HOME/.local/bin" # andromeda node
