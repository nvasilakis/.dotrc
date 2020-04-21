DOTRC=~/.dotrc

# Emscripten
# export PATH="/Users/nvasilakis/lab/emscripten/emsdk-portable:$PATH"
# export PATH="/Users/nvasilakis/lab/emscripten/emsdk-portable/clang/e1.37.28_64bit:$PATH"
# export PATH="/Users/nvasilakis/lab/emscripten/emsdk-portable/node/4.1.1_64bit/bin:$PATH"
# export PATH="/Users/nvasilakis/lab/emscripten/emsdk-portable/emscripten/1.37.28:$PATH"

#Setting environment variables:
# export EMSDK="/Users/nvasilakis/lab/emscripten/emsdk-portable"
# export EM_CONFIG="/Users/nvasilakis/.emscripten"
# export BINARYEN_ROOT="/Users/nvasilakis/lab/emscripten/emsdk-portable/clang/e1.37.28_64bit/binaryen"
# export EMSCRIPTEN="/Users/nvasilakis/lab/emscripten/emsdk-portable/emscripten/1.37.28"

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
if [[ $(hostname) == 'helios' ]]; then
  PATH="$PATH:/usr/local/opt/python@3.8/bin"
fi
if [[ `uname` == 'Linux' ]]; then
  # OCaml
  . /home/$(whoami)/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  # emacs on Gnome
  alias emacs='XLIB_SKIP_ARGB_VISUALS=1 emacs'
  export PATH=~/.npm-global/bin:$PATH
  export JAVA_HOME=/usr/lib/jvm/default-java
else
  # Haskell
  export PATH="$PATH:/Users/$(whoami)/Library/Haskell/bin"
  export PATH="/usr/local/bin:$PATH"
  export PATH="$PATH:/Library/TeX/texbin/"
  # Java
  JVM_BASE_DIR=/Library/Java/JavaVirtualMachines
  JVM_VERSION=$(ls $JVM_BASE_DIR | grep -Eo "([0-9]+\.?){3}(_[0-9]+)?" | sort -Vr | head -1)

  if [ -n "$JVM_VERSION" ]; then
    export JAVA_HOME="$(find $JVM_BASE_DIR -maxdepth 1 -name "*${JVM_VERSION}*")/Contents/Home"
    # echo "Setting JAVA_HOME to $JAVA_HOME."
  fi
fi

stars=$(cat <<'STARLIST'
alpha.ndr.md
beta.ndr.md
gamma.ndr.md
delta.ndr.md
deathstar.cis.upenn.edu
livestar.cis.upenn.edu
memstar.cis.upenn.edu
STARLIST
)

export stars

andromeda1() {
  andromeda '{"nodes": 1}'
}

showpipeline() {
  grep '|' $1 | sed 's/#.*$//' | awk '{$1=$1};1' | sed '/^$/d'
}


# DCP
# dcp=$lab/dcp
# alias lh="http://localhost:8000/"
# l="http://localhost:8000/"

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export PATH="$PATH:$HOME/.local/bin" # andromeda node
export PATH=~/.npm-global/bin:$PATH

export NPM_PACKAGES="${HOME}/.npm-packages"
# export PATH="$NPM_PACKAGES/bin:$PATH"
export PATH="$PATH:$NPM_PACKAGES/bin"
# NPM non-sudo
NPM_PACKAGES="${HOME}/.npm-packages"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
