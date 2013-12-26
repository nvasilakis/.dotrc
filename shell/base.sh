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
  alias au='sudo apt-get update'
  alias here='nautilus --no-desktop --browser .'
  alias e='emacs --geometry=160x50+500' 
  alias open='xdg-open'
  #alias emacs='emacs -nw'
  #alias w3m='w3m www.google.com'
else 
  export CLICOLOR=1
  alias ls='ls -G'
  export GREP_OPTIONS='--color=auto';
  export GREP_COLOR='00;31;5;157';
  alias e='/Applications/Emacs.app/Contents/MacOS/Emacs'
  alias emacs='emacs -nw'
  alias ctags='/usr/local/bin/ctags'
fi

export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=35;100:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36'

# server connection
alias quark='ssh nvas@quark.seas.upenn.edu'
alias eniac='ssh nvas@eniac.seas.upenn.edu'
alias vslks='ssh root@vasilak.is'
alias anti='ssh nikos@antikythera.vasilak.is'
alias ceid='ssh nikos@diogenis.ceid.upatras.gr'

# breeze?
alias rsc='rsync -av --progress'
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs -l'
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
