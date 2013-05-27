# Show the number of background jobs -- only if there are any
function show-jobs {
  if $(jobs | grep -v '^$' &> /dev/null) ; then
    #echo '[%{$bold_color$fg[blue]%}%j%{$reset_color%}]'
    echo '[%j]'
  fi
}

# Usually when cd, I also ls
function cd {
  builtin cd $* && ls
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
function laconic () {
  if [[ $1 == 'true' || $1 == 'on' ]]; then
    export LACONIC="true"
    RPS1=$'$(show-jobs)'
  elif [[ $1 == 'false' || $1 == 'off' ]]; then
    echo "FALSE"
    export LACONIC="no"
    RPS1=$'${vcs_info_msg_0_}$(show-jobs)'
  fi
  echo "Sourcing ~/.${SHELL}rc.."
  source ~/.${SHELL}rc
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
