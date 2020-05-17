LANG="en_US.UTF-8"
LANGUAGE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

# Prompt-related functions

show-jobs() {
  if $(jobs | grep -v '^$' &> /dev/null) ; then
    #echo '[%{$bold_color$fg[blue]%}%j%{$reset_color%}]'
    echo '[%j]'
  fi
}

LGR=""   # Latest Git Root

show-git-status() {
  IN_GIT="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
	if [ "$IN_GIT" ]; then
    CGR=$(git rev-parse --show-toplevel)
    if [[ "$LGR" != "$CGR" ]]; then
      git status -sb # --show-stash
      git branch
      LGR="$CGR"
    fi
  fi
}

npm-publish() {
  echo "npm public publish"
  if [ ! -f ./package.json ]; then
    echo "No package.json found!"
  else
    if grep -q '@andromeda/' ./package.json; then
      echo 'log-in as andromeda (waiting for 2s)'
      sleep 2
      npm login andromeda && npm publish --access=public
    else
      echo 'log-in as nvasilakis (waiting for 2s)'
      sleep 2
      npm login nvasilakis && npm publish --access=public
    fi
  fi

}

get() {
  curl -sX${2:-"GET"} -H"Content-type: application/json" -d${3:-""} "http://localhost:8080/${1:-""}"
}


showpipeline() {
  grep '|' $1 | sed 's/#.*$//' | awk '{$1=$1};1' | sed '/^$/d'
}

cd() {
  builtin cd $* && ls
  show-git-status
}

mkd() {
  mkdir -p $* && cd $*
}

f() {
  fg %$*
}

b() {
  bg %$*
}

# Wraps a command with callback to notify the user when this is done
# (an excellent example of functional-style bash scripting needs!)
letmeknow() {
  # Check OS X or Typical Linux (Debian, Ubuntu)
  # TODO: Need to change message with actual event
  if $(command -v terminal-notifier >/dev/null 2>&1); then
    tfail='terminal-notifier {} -title "FAIL!"  -message "Just to let you know.." -sound "Ping"'
    tsuccess='terminal-notifier {} -title "SUCCESS!"  -message "Just to let you know.." -sound "Pop"'
  elif $(command -v notify-send >/dev/null 2>&1); then
    tfail='notify-send "FAIL!" "Just to let you know.." -i /usr/share/pixmaps/gnome-color-browser.png -t 5000 && paplay /usr/share/sounds/gnome/default/alerts/drip.ogg'
    tsuccess='notify-send "SUCCESS!" "Just to let you know.." -i /usr/share/pixmaps/gnome-color-browser.png -t 5000 && paplay /usr/share/sounds/gnome/default/alerts/drip.ogg'
  else # Add sound
    tfail='echo "$(tput setaf 1) $(tput bel) FAIL $(tput sgr 0)"'
    tsuccess='echo "$(tput setaf 2) $(tput bel) FAIL $(tput sgr 0)"'
  fi
  $* && eval ${tsuccess} || eval ${tfail}
}

latexcleanup() {
  rm -f *-blx.bib
  rm -f *.aux
  rm -f *.bbl
  rm -f *.blg
  rm -f *.log
  rm -f *.out
  rm -f *.run.xml
  rm -f *.bcf
}

# git-related aliases

ggl() {
  size='20'
  # if a number
  if [[ "${1}" =~ ^[0-9]+$ ]] ; then
    size="${1}"
  fi
  git lg | head -n ${size} | nl -w 2
}

gg() {
  if [[ "${1}" =~ ^[0-9]+$ ]] ; then
    git log --pretty=format:'%h'  | sed -n ${1}p
  else
    echo "Wrong argument"
    return 1 
  fi
}

pull-all() {
  for d in ${1:-$(pwd)/*/}; do
    cd $d;
    [ $(git rev-parse --is-inside-work-tree) = "true" ] && git pull
    cd ..
  done
}

alias gga='git add'
alias ggr='git reset HEAD'
alias ggc='git commit -v'
alias ggs='git status -sb'
alias ggp='git push'
alias ggh='git checkout'
alias ggb='git branch'
alias ggd='git diff --word-diff'

# Show memory, mainly on Linux
# TODO: make it universal -- maybe query top?
function mem {
  echo "In use:\t\e[00;31m$(free | grep Mem | awk '{print $3/$2 * 100.0}')\e[00m\t%"
  echo "Free:\t\e[00;31m$(free | grep Mem | awk '{print $4/$2 * 100.0}')\e[00m\t%"
}

# When a system does not have tac
TAC=$(which tac)
tac() {
  $TAC 2> /dev/null $* || tail -r $*
}

ec2-ssh() {
  ssh -i "${HOME}/Dropbox/keys/ec2.pem" ubuntu@$1
}

ec2-rsync() {
  rsync --progress -rave "ssh -i ${HOME}/Dropbox/keys/ec2.pem" $@
}

ec2-sync-slaves() {
  SRV="ubuntu@ec2-3-15-201-13.us-east-2.compute.amazonaws.com:~ ubuntu@ec2-3-15-20-212.us-east-2.compute.amazonaws.com:~ ubuntu@ec2-18-217-56-181.us-east-2.compute.amazonaws.com:~"
  
  for s in $SRV; do
    echo $1 '===>' $s
    rsync --progress -rave "ssh -i ${HOME}/Dropbox/keys/ec2.pem" $1 $s
  done
}

