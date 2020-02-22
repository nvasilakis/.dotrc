# TODO: Environment should come before, aliases next  

# Based on Environment
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
  alias here='nautilus --no-desktop --browser .'
  # open everything, a la OS X
  function open {
    for f in $*; do
      xdg-open "${f}" &> /dev/null
    done
  }
  #alias w3m='w3m www.google.com'
  alias ctags='/usr/bin/ctags-exuberant'
else 
  export CLICOLOR=1
  alias ls='ls -G'
  export GREP_OPTIONS='--color=auto';
  export GREP_COLOR='00;31;5;157';
  alias e='/Applications/Emacs.app/Contents/MacOS/Emacs'
  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  #alias emacs='emacs -nw'
  alias ctags='/usr/local/bin/ctags'
  export PATH="$HOME/.cabal/bin:${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin:$PATH"
fi

export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=35;100:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36'

# server connection
alias quark='ssh nvas@quark.seas.upenn.edu'
alias eniac='ssh nvas@eniac.seas.upenn.edu'
alias vslks='ssh root@vasilak.is'
alias anti='ssh nikos@antikythera.vasilak.is'
alias ceid='ssh nikos@diogenis.ceid.upatras.gr'
alias rupdoc='ssh nikos@centaurus.vasilak.is "cd /var/www/ndr.md/doc; git pull; cd -;"'
alias seas='ssh nvas@eniac.seas.upenn.edu -X "google-chrome"'
# alias reverse='(tac 2> /dev/null || tail -r)'
TAC=$(which tac)
function tac {
  $TAC 2> /dev/null $* || tail -r $*
}

# breeze?
alias rsc='rsync -av --progress'
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs -l'
alias m='make'
alias mc='make clean && make'
alias vim='vim -p'
alias gga='git add'
alias ggc='git commit -v'
alias ggs='git status -sb'
alias ggp='git push'
alias ggh='git checkout'
alias ggb='git branch'
alias ggd='git diff --word-diff'
alias rseas='rdesktop vlab-rdp.seas.upenn.edu'
# Instead of adding something to /usr/bin
alias off='echo HALTING SYSTEM; sudo shutdown -h now'
alias idea='/media/w7/Projects/idea/bin/idea.sh'
# Hadoop-related
unalias fs &> /dev/null
alias hfs='hadoop fs'
unalias hls &> /dev/null
alias hls='hfs -ls'

# Working environment -- TODO: Make transparent
alias breeze='/Users/nv/Projects/UPenn/Research/svn-safe/breeze/breeze'
# Breeze interpreter
alias breeze='/media/w7/Projects/UPenn/SAFE/SAFE/breeze/breeze-interpreter/src/dist/build/breeze/breeze'
alias jhf='cd ~/Work/oceanus/handsfree/git/'
alias jto='cd ~/Work/apache-tomcat-6.0.35/'
alias jbuild='cd ~/handsfree/Handsfree/; svn update; ant build-beta; mv distribution/Handsfree-beta.war /oceanus/www/webapps;'
alias gkallas='GIT_COMMITTER_NAME="Konstantinos Kallas" GIT_COMMITTER_EMAIL="konstantinos.kallas@hotmail.com" git commit --author="Konstantinos Kallas <konstantinos.kallas@hotmail.com>"'

#PATH="${PATH}:/scratch/safe/usr/modelsim/modeltech/bin:/scratch/safe/usr/Bluespec-2013.05.beta2/bin/"
#export LM_LICENSE_FILE="2100@potato.cis.upenn.edu:1709@potato.cis.upenn.edu:1717@potato.cis.upenn.edu:27010@potato.cis.upenn.edu:27009@potato.cis.upenn.edu"
#export BLUESPECDIR=/scratch/safe/usr/Bluespec-2013.05.beta2/lib

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#
# needs to start with `autoload -Uz compinit` on zsh
# https://apple.stackexchange.com/questions/296477/my-command-line-says-complete13-command-not-found-compdef/340718

# COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
# COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
# export COMP_WORDBREAKS
# 
# if type complete &>/dev/null; then
#   _npm_completion () {
#     local si="$IFS"
#     IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
#                            COMP_LINE="$COMP_LINE" \
#                            COMP_POINT="$COMP_POINT" \
#                            npm completion -- "${COMP_WORDS[@]}" \
#                            2>/dev/null)) || return $?
#     IFS="$si"
#   }
#   complete -F _npm_completion npm
# elif type compdef &>/dev/null; then
#   _npm_completion() {
#     si=$IFS
#     compadd -- $(COMP_CWORD=$((CURRENT-1)) \
#                  COMP_LINE=$BUFFER \
#                  COMP_POINT=0 \
#                  npm completion -- "${words[@]}" \
#                  2>/dev/null)
#     IFS=$si
#   }
#   compdef _npm_completion npm
# elif type compctl &>/dev/null; then
#   _npm_completion () {
#     local cword line point words si
#     read -Ac words
#     read -cn cword
#     let cword-=1
#     read -l line
#     read -ln point
#     si="$IFS"
#     IFS=$'\n' reply=($(COMP_CWORD="$cword" \
#                        COMP_LINE="$line" \
#                        COMP_POINT="$point" \
#                        npm completion -- "${words[@]}" \
#                        2>/dev/null)) || return $?
#     IFS="$si"
#   }
#   compctl -K _npm_completion npm
# fi
###-end-npm-completion-###
