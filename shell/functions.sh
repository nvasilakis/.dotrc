# Show the number of background jobs -- only if there are any
function show-jobs {
  if $(jobs | grep -v '^$' &> /dev/null) ; then
    #echo '[%{$bold_color$fg[blue]%}%j%{$reset_color%}]'
    echo '[%j]'
  fi
}

function npp {
    echo "npm public publish"
    if [ ! -f ./package.json ]; then
        echo "No package.json found!"
    else
        if grep -q '@andromeda/' ./package.json; then
            echo 'log-in as andromeda!'
            npm login andromeda && npm publish --access=public
        else
            echo 'log-in as andromeda!'
            npm login nvasilakis && npm publish --access=public
        fi
    fi

}

function url {
    curl -sX${2-"GET"} -H"Content-type: application/json" -d${3-""} "http://localhost:8080/$1"
}

# Latest Git Root
LGR=""

function show-git-status {
  # TODO check if `git` exists
  IN_GIT="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
	if [ "$IN_GIT" ]; then
    CGR=$(git rev-parse --show-toplevel)
    if [[ "$LGR" != "$CGR" ]]; then
      git status -sb --show-stash
      git branch
      LGR="$CGR"
    fi
  fi
}

# Usually when cd, I also ls
function cd {
  builtin cd $* && ls
  show-git-status
}

# Usually when mkdir, I also cd
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

# Show memory, mainly on Linux
# TODO: make it universal -- maybe query top?
function mem {
  echo "In use:\t\e[00;31m$(free | grep Mem | awk '{print $3/$2 * 100.0}')\e[00m\t%"
  echo "Free:\t\e[00;31m$(free | grep Mem | awk '{print $4/$2 * 100.0}')\e[00m\t%"
}

# Push and pull work from TJU
function pushwork {
  tar cvzf ~/work.tar.gz ~/Work/; 
  rsync -av --progress ~/work.tar.gz nvas@eniac.seas.upenn.edu:~
}
function pullwork {
  cd $HOME;
  rsync -av --progress nvas@eniac.seas.upenn.edu:~/work.tar.gz .;
  echo -n "Backing up work..";
  cp -r ~/Work/ ~/Work_BK; 
  echo "..done!"; 
  tar xvzf ~/work.tar.gz
  cd $OLDPWD;
}

# enable defensive resource allocation on prompt
# this is also useful for systems that do not properly support UTF-8 and
# colors (TODO: further investigation of why these systems mis-behave
# is needed) -- zsh--only
#TODO: find out shell correctly, 
function laconic () {
  if [[ $1 == 'true' || $1 == 'on' || "${LACONIC}" == 'false' ]]; then
    export LACONIC="true"
    RPS1=$'$(show-jobs)'
  elif [[ $1 == 'false' || $1 == 'off' || "${LACONIC}" == 'true' ]]; then
    echo "Disabling laconic PS4"
    export LACONIC="false"
    RPS1=$'${vcs_info_msg_0_}$(show-jobs)'
  fi
}

function ggl {
  size='20'
  # if a number
  if [[ "${1}" =~ ^[0-9]+$ ]] ; then
    size="${1}"
  fi
  git lg | head -n ${size} | nl -w 2
}

function gg {
  if [[ "${1}" =~ ^[0-9]+$ ]] ; then
    git log --pretty=format:'%h'  | sed -n ${1}p
  else
    echo "Wrong argument"
    return 1 
  fi
}
##
# If you have LZO compression enabled in your Hadoop cluster and
# compress job outputs with LZOP (not covered in this tutorial):
# Conveniently inspect an LZOP compressed file from the command
# line; run via:
#
# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
#
# Requires installed 'lzop' command.
##
lzohead () {
    hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

##
# When forgetting how to invoke a tiny command
##
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

function remindmeto {
  # todo OSX:
  # http://stackoverflow.com/questions/5588064/how-do-i-make-a-mac-terminal-pop-up-alert-applescript
  # Also find notification center even on other platforms
  if [[ $# == 0 ]]; then
    cat <<-__EOF
			
			NAME
			    remindmeto - Reminds user of anything if he is on-screen.
			
			SYNOPSIS
			    remindmeto <dosomething> at <time>
			
			DESCRIPTION
			    Remindmeto feeds users with small bursts of text at
			    pre-specified to remind them what they need to remember at
			    this point in time. All entries are mandatory, otherwise this
			    help is printed.
			
			    <dosomething> : arbitrary text (optionally containing "at")
			
			    <time> : Can be a combination of the following formats:
			      * Time: one- or two-digit number (0-23) to indicate the start of an
			        hour on a 24-hour clock (e.g., 13 is 13:00 or 1:00pm).
			      * Date: keywards (e.g., today, tomorrow), day of week 
			        (e.g., Monday) or fully qualified date (e.g., November 9, 2010).
			      * Increment: period relative to now, using "+" followed by a number
			        and one of {minutes, hours, days, months, years}.
			
			AUTHOR
			    Written by Nikos Vasilakis
			
			COPYRIGHT
			    Copyright © 2013 Nikos Vasilakis.  License GPLv3+: GNU GPL version 3 
			    or later  <http://gnu.org/licenses/gpl.html>.  This is free software: 
			    you are free to  change and  redistribute  it. There is NO  WARRANTY,
			    to the extent permitted by law.
			
			__EOF
  else
    # remindmeto drink milk at 6
    # remindmeto return book at the library at 6
    when="$(echo "${*}" | sed 's/^.*at//')"
    #what="$(echo "${*}" | sed 's/^\(.*\)at/\1/')"
    what="$(echo "${*}" | sed 's/^\(.*\)at.*$/\1/' | sed -e 's/^\(.\)/\u\1/g')"
    #what="$(echo "${*}" | sed "s/${when}//")"
    if [[ "${1}" == "debug" ]]; then
      echo "all:  $*"
      echo "when: ${when}"
      echo "what: ${what}"
    fi
    at "${when}" <<-__EOF
			notify-send "Hey!" "${what}!" -i /usr/share/pixmaps/gnome-color-browser.png -t 5000
			paplay /usr/share/sounds/gnome/default/alerts/drip.ogg
			atq
			__EOF
    rat=$?
    if [[ $rat != 0 ]]; then
      echo "\e[00;31mThere was an ERROR, $(whoami) -- Please resubmit!"
    fi
  fi
}

function setLocales {
  LANG=en_US.UTF-8
  LANGUAGE=en_US.UTF-8
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
}

function playfwd () {
  for d in $UNIVERSE; do
    ls $d;
    cd $d;
    git pull;
  done
}


function 555fetch () {
  if [[ $# == 1 ]]; then
    mkdir testfield && cd testfield
    rsync -av --progress cis455@eniac.seas.upenn.edu:/home1/c/cis455/submit/hw1ms1/${1}.Z .
    uncompress ${1}.Z && tar xvf ${1} && unzip submit-hw1.zip && cp ../hw1m1/runserver.sh .
    ant build
    cat README
  fi
}

# Wraps a command with callback to notify the user when this is done
# (an excellent example of functional-style bash scripting needs!)
function letmeknow {
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

function latexcleanup {
  rm -f *-blx.bib
  rm -f *.aux
  rm -f *.bbl
  rm -f *.blg
  rm -f *.log
  rm -f *.out
  rm -f *.run.xml
  rm -f *.bcf
}
