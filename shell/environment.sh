HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTFILESIZE=100000
HISTCONTROL=ignoredups:ignorespace

export EDITOR="vim"
export SVN_EDITOR="vim"

## Use vim as man page viewer. If I need to remap K, add also:
#-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"\
## or
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod modified nonumber nolist autoread' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nonumber nolist' -c 'noremap q ZQ' -c 'map <SPACE> <C-D>' -\" "

lab=$HOME/wrk
tools=$HOME/tools

# JavaScript: Emscripten
if [ -d "$tools/emscripten/emsdk-portable" ]; then
  export PATH="$tools/emscripten/emsdk-portable:$PATH"
  export PATH="$tools/emscripten/emsdk-portable/clang/e1.37.28_64bit:$PATH"
  export PATH="$tools/emscripten/emsdk-portable/node/4.1.1_64bit/bin:$PATH"
  export PATH="$tools/emscripten/emsdk-portable/emscripten/1.37.28:$PATH"
  export EMSDK="$tools/emsdk-portable"
  export EM_CONFIG=~/.emscripten
  export BINARYEN_ROOT="$tools/emscripten/emsdk-portable/clang/e1.37.28_64bit/binaryen"
  export EMSCRIPTEN="$tools/emscripten/emsdk-portable/emscripten/1.37.28"
fi 

if [ -d "$tools/hadoop-3.2.1" ]; then
  export HADOOP_HOME="$tools/hadoop-3.2.1"
  export PATH="$PATH:$tools/hadoop-3.2.1/bin"
fi

if [ -d "$tools/spark-2.4.5-bin-hadoop2.7" ]; then
  export PATH="$PATH:$tools/spark-2.4.5-bin-hadoop2.7/bin"
fi

# Python
if [ -d "/usr/local/opt/python@3.8/bin" ]; then
  PATH="$PATH:/usr/local/opt/python@3.8/bin"
fi
export PYTHONSTARTUP=~/.pythonrc # decide if it's the same for python2 python3

# Haskell: Cabal
if [ -d "$HOME/.ghcup/bin" ]; then
  export PATH="$HOME/.ghcup/bin:$PATH"
  export PATH="$HOME/.cabal/bin:$PATH"
fi

# Node: npm
if [ -f "${HOME}/.npmrc" ]; then
  export NPM_PACKAGES=$(cat ${HOME}/.npmrc | grep 'prefix=' | sed 's;prefix=;;' | sed "s;~;$HOME;")
  export PATH="$NPM_PACKAGES/bin:$PATH"
  # Preserve MANPATH if you already defined it somewhere in your config.
  # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
  export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
fi

# Ocaml: OPAM
if [ -d "$HOME/.opam/opam-init" ]; then
  if [ $SHELL = "zsh" ]; then
    . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  else
    . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
  fi
fi

if [ -d "$tools/dish-parser" ]; then
  alias dparse=$tools/dish-parser/parse_to_json.native
  alias demit=$tools/dish-parser/json_to_shell.native
fi

# Java: Oracle's JDK 8
if [[ $(uname) == 'Linux' ]]; then
  # OpenJDK: /usr/lib/jvm/default-java
  export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_251
else
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home
fi

# Hadoop
alias hfs='hadoop fs'
alias hls='hfs -ls'

# If Hadoop logs are LZOP'd, inspect w/ lzohead /hdfs/path/to/lzop/file.lzo
lzohead () {
    hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

if [[ `uname` == 'Linux' ]]; then 
  if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
  alias ai='sudo apt-get install'
  alias au='sudo apt-get update && sudo apt-get upgrade -y'
  alias open='nautilus --no-desktop --browser .'
  #alias w3m='w3m www.google.com'
  # alias ctags='/usr/bin/ctags-exuberant'
else 
  export CLICOLOR=1
  alias ls='ls -G'
  export GREP_OPTIONS='--color=auto';
  export GREP_COLOR='00;31;5;157';
  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  #alias emacs='emacs -nw' #terminal-only emacs
  # alias ctags='/usr/local/bin/ctags'
fi

alias chrome-uni='ssh nvas@eniac.seas.upenn.edu -X "google-chrome"'
alias syn='rsync -av --progress'
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs -l'
alias m='make'
alias mc='make clean && make'
alias vim='vim -p'
alias rseas='rdesktop vlab-rdp.seas.upenn.edu'
# alias mirgen='java -jar ~/wrk/andromeda/mir/static-analysis/mir-sa.jar . | grep "^{" | jq .'
alias to='dirs -v; echo -n "..>"; read n; cd ~$n'

# Andromeda
a=$lab/andromeda
core=$a/andromeda
doc=$a/doc
alias ad="cd $a/doc"
alias a="cd  $a"
alias pt="cd $a/doc/thesis/proposal/tex"
alias dt="cd $a/doc/thesis/defense/tex"
alias research="cd $lab/andromeda/doc/research"
alias a1='andromeda \{\"nodes\": 1\}'

alias lya-dev="$a/lya/lya.js"

alias gkallas='GIT_COMMITTER_NAME="Konstantinos Kallas" GIT_COMMITTER_EMAIL="konstantinos.kallas@hotmail.com" git commit --author="Konstantinos Kallas <konstantinos.kallas@hotmail.com>"'
