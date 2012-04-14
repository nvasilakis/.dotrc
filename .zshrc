# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
DIRSTACKSIZE=10
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nv/.zshrc'

autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
autoload -U colors && colors
# Add a variable for my custom killing widget!
marking=0
zmodload zsh/complist

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

setopt complete_in_word
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' menu 'select=0'
#zstyle ':completion:*:windows' menu on=0
zstyle ':completion:::::' completer _complete _prefix _approximate
zstyle ':completion::prefix:::' completer _complete 
zstyle ':completion:*:prefix:*' add-space true
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) )'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
# tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# Tab completion for pkill
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always


# Setting options
# Advanced spell-checking
setopt CORRECTALL
# Do not append commands that start with space in history stack
setopt HISTIGNORESPACE
# Ignore duplucate history entries
setopt HISTIGNOREDUPS
# Include variables and other usefull stuff in the prompt
setopt PROMPTSUBST
# set option for ext. globbing:
# ^ - negated matches (not at the begining of a word)
# ~ - pattern exceptions
# # - multiple matches (not at the begining of a word)
setopt EXTENDEDGLOB
# Storing extra history information such as time etc
setopt EXTENDEDHISTORY
# Make use of the directory stack 
setopt AUTOPUSHD #pushdminus pushdsilent pushdtohome
# No need of the cd command
setopt AUTOCD 
# Option to complete aliases also
setopt COMPLETEALIASES

# Edit the current line in the $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line
autoload bash-backward-kill-word
zle -N backward-kill-word bash-backward-kill-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
#bindkey '\C-I' reverse-menu-complete
bindkey \^U backward-kill-line

#local _myhosts
#if [[ -f $HOME/.ssh/known_hosts ]]; then
#  _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
#  zstyle ':completion:*' hosts $_myhosts
#fi

compdef pkill=killall
zstyle ':completion:*:kill:*:processes' command "ps aux"
zstyle ':completion:*:killall:*:processes' command "ps aux"


if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi
hosts=(
	"$_etc_hosts[@]"
	localhost
  150.140.90.86
  150.140.91.13 
  vasilak.is 
  diogenis.ceid.upatras.gr 
  zenon.ceid.upatras.gr 
  eniac.seas.upenn.edu
  biglab.seas.upenn.edu
  speclab.seas.upenn.edu
)
zstyle ':completion:*' hosts $hosts
my_accounts=(
	root@localhost
  nv@150.140.90.86
  etp@150.140.91.13 
  root@vasilak.is 
  basilakn@diogenis.ceid.upatras.gr 
  basilakn@zenon.ceid.upatras.gr 
  nvas@eniac.seas.upenn.edu
  nvas@biglab.seas.upenn.edu
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
# tab completion for ssh
zstyle ':completion:*:*:ssh:*' menu yes select
zstyle ':completion:*:ssh:*' force-list always

# Handy Alias
if [[ `uname` == 'Linux' ]]; then 
  if [ -x /usr/bin/dircolors ]; then
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
  #
else 
  export CLICOLOR=1
  #export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:
  alias ls='ls -G'
fi

# some more aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs -l'
alias f='fg'
alias b='bg'
alias ai='sudo apt-get install'
alias au='sudo apt-get update'
alias vim='vim -p'
alias -g prj='/media/w7/Projects/'
alias -g cv='/media/w7/Projects/cv/'
alias gga='git add'
alias ggc='git commit -v'
alias ggs='git status -sb'
alias ggp='git push'
alias ggh='git checkout'
alias ggl='git log --graph --decorate --oneline'
alias ggd='git diff --word-diff'
alias -g mam='nv@150.140.90.86'
alias -g etp='etp@150.140.91.13'
alias -g is='root@vasilak.is'
alias -g diogenis='basilakn@diogenis.ceid.upatras.gr'
alias -g zenon='basilakn@zenon.ceid.upatras.gr'
alias dh='dirs -v'
# I shoud add functionality for go seas, ceid, rdesktop
# if [[ $n -eq 'seas']]; then echo "ssh seas.." fi;
alias go='dirs -v ; echo -n "..>" ; read n ; cd ~$n'
alias rseas='rdesktop vlab-rdp.seas.upenn.edu'
alias emacs='emacs -nw'

# Nice Exports
export EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nonumber nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \
    "
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod modified nonumber nolist autoread' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \

if [[ `hostname` == 'nv' ]]; then 
  # Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_26/";
  # Set Hadoop-related environment variables
  export HADOOP_HOME=/usr/local/hadoop
  # Now we can cd from anywhere
  export CDPATH="/media/w7/Projects/"
  # Add Hadoop bin/ directory to PATH
  export PATH=$PATH:$HADOOP_HOME/bin

elif [[ `hostname` == 'cis555-vm' ]] ; then
  export PATH=$PATH:/home/cis555/555/.tools
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
fi;

# vcs_info
# ☡ ∫ S ⨌  for subversion
# ❄ ✺ for Darcs
#  for CVS
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable hg git bzr svn
zstyle ':vcs_info:(hg*|git*|bzr):*' get-revision true
zstyle ':vcs_info:(hg*|git*|bzr):*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}[%f%s%F{5}%F{3}|%F{5}%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(svk|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' unstagedstr "✘"
zstyle ':vcs_info:*' stagedstr "✔"

# ± for git
zstyle ':vcs_info:git:*' actionformats "[± %a|%8.8i %b %c%u%m]"
zstyle ':vcs_info:git*' formats "[±|%b %8.8i %{${fg[green]}%}%c%{${fg[red]}%}%u%{$reset_color%}%m]"
zstyle ':vcs_info:git*+set-message:*' hooks git-stash git-st 
precmd () { 
  vcs_info 
}

# Show remote ref name and number of commits ahead-of or behind
function +vi-git-st() {
    local ahead behind remote
    local -a gitstatus

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        # for git prior to 1.7
        # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        (( $ahead )) && gitstatus+=( "${c3}+${ahead}${c2}" )

        # for git prior to 1.7
        # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
        (( $behind )) && gitstatus+=( "${c4}-${behind}${c2}" )

        hook_com[misc]="${(j:/:)gitstatus}${hook_com[misc]}"
    fi
}

# Show count of stashed changes
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+=" (${stashes} stashed)"
    fi
}

# ☤☿ for mercurial
zstyle ':vcs_info:hg:*' actionformats "[☿ %a|%8.8i %b %c%u%m]"
zstyle ':vcs_info:hg*' formats "[☿|%b %{${fg[green]}%}%c%{${fg[red]}%}%u%{$reset_color%}%m]"
zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
#zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c%p"
#zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c%p"

zstyle ':vcs_info:hg*:*' hgrevformat "%8.8h/%r" # only show local rev.
zstyle ':vcs_info:hg*:*' branchformat "%b %r"
#zstyle ':vcs_info:hg*+set-hgrev-format:*' hooks hg-hashfallback
#zstyle ':vcs_info:hg*+set-message:*' hooks mq-vcs

function +vi-hg-hashfallback() {
    if [[ -z ${hook_com[localrev]} ]] ; then
        local -a parents

        parents=( ${(s:+:)hook_com[hash]} )
        parents=( ${(@r:12:)parents} )
        hook_com[rev-replace]="${(j:+:)parents}"

        ret=1
    fi
}

### Show when mq itself is under version control
function +vi-mq-vcs() {
    # if [[ -d ${hook_com[base]}/.hg/patches/.hg ]]; then
        # hook_com[hg-mqpatch-string]="mq:${hook_com[hg-mqpatch-string]}"
    # fi
}

# ☡ ∫ S ⨌  for subversion
zstyle ':vcs_info:svn:*' actionformats "[S %a|%8.8i %b %c%u%m]"
zstyle ':vcs_info:svn*' formats "[S|%b %{${fg[green]}%} %m%{$reset_color%}]"
zstyle ':vcs_info:svn*:*' branchformat "%b %r"
zstyle ':vcs_info:svn*+set-message:*' hooks svn-info

# Show info regarding subversion
function +vi-svn-info() {
    svn_status="$(svn status 2> /dev/null )"
    svn_add="$( echo ${svn_status} | grep '^A[ ]*.*' )"
    svn_modify="$(echo ${svn_status} | grep '^M[ ]*.*' )"
    svn_under="$(echo ${svn_status}  | grep '^\?[ ]*.*' )"
    svn_deletion="$(echo ${svn_status} | grep '^D[ ]*.*' )"
    svn_conflict="$(echo ${svn_status} | grep '^C[ ]*.*' )"
    pattern="^A[ ]*.*"
    #local -a gitstatus

    hook_com[misc]=''
    if [ $svn_add ]; then
      hook_com[misc]+="A"
    fi
    if [ $svn_modify ]; then
      hook_com[misc]+="M"
    fi
    if [ $svn_under ]; then
      hook_com[misc]+="?"
    fi
    if [ $svn_deletion ]; then
      hook_com[misc]+="D"
    fi
    if [ $svn_conflict ]; then
      hook_com[misc]+="C"
    fi


#    # Are we on a remote-tracking branch?
#    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
#        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
#
#    if [[ -n ${remote} ]] ; then
#        # for git prior to 1.7
#        # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
#        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
#        (( $ahead )) && gitstatus+=( "${c3}+${ahead}${c2}" )
#
#        # for git prior to 1.7
#        # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
#        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
#        (( $behind )) && gitstatus+=( "${c4}-${behind}${c2}" )
#
#        hook_com[misc]="${(j:/:)gitstatus}${hook_com[misc]}"
#    fi
}


## simplex
update_current_git_vars(){
unset __CURRENT_GIT_BRANCH
unset __CURRENT_GIT_BRANCH_STATUS
unset __CURRENT_GIT_BRANCH_IS_DIRTY

local st="$(git status 2>/dev/null)"
if [[ -n "$st" ]]; then
	local -a arr
	arr=(${(f)st})

	if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
		__CURRENT_GIT_BRANCH='no-branch'
	else
		__CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
	fi

	if [[ $arr[2] =~ 'Your branch is' ]]; then
		if [[ $arr[2] =~ 'ahead' ]]; then
			__CURRENT_GIT_BRANCH_STATUS='ahead'
		elif [[ $arr[2] =~ 'diverged' ]]; then
			__CURRENT_GIT_BRANCH_STATUS='diverged'
		else
			__CURRENT_GIT_BRANCH_STATUS='behind'
		fi
	fi

	if [[ ! $st =~ 'nothing to commit' ]]; then
		__CURRENT_GIT_BRANCH_IS_DIRTY='1'
	fi
fi
}

prompt_git_info(){
if [ -n "$__CURRENT_GIT_BRANCH" ]; then
	local s="["
	s+="$__CURRENT_GIT_BRANCH"
	case "$__CURRENT_GIT_BRANCH_STATUS" in
		ahead)
		s+="↑"
		;;
		diverged)
		s+="↕"
		;;
		behind)
		s+="↓"
		;;
	esac
	if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
		s+="±"
	fi
	s+="]"
# Add color withing quotes %{$bold_color$fg[blue]%} 
	printf "%s%s" "" $s
fi
}

chpwd_update_git_vars() {
update_current_git_vars
}

preexec_update_git_vars() {
case "$1" in 
	git*)
	__EXECUTED_GIT_COMMAND=1
	;;
esac
}

precmd_update_git_vars(){
if [ -n "$__EXECUTED_GIT_COMMAND" ]; then
	update_current_git_vars
	unset __EXECUTED_GIT_COMMAND
fi
}

ena(){
  #if [[ $(echo '%j') == "0" ]] ; then
  if $(jobs | grep -v '^$' &> /dev/null) ; then
    #echo '[%{$bold_color$fg[blue]%}%j%{$reset_color%}]'
    echo '[%j]'
  fi
#  if [[%j == 0]]; then
#    echo %j ena 
#  fi
}
#  number=$(jobs)
#  if [[ $number == "" ]]; then
# .ena.duo' #%{$fg[blue]%}[%j])

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '
PS1=$'%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$bold_color$fg[blue]%}%2~%{$reset_color%}%#'
#RPS1=$'$(prompt_git_info)'
RPS1=$'${vcs_info_msg_0_}$(ena)'  #%($(ena).[%{$bold_color$fg[blue]%}%j%{$reset_color%}].)
PS4=$'+%N:%i:%_>'

# PROMPT=%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:$(prompt_git_info)%{$bold_color$fg[blue]%}%~%{$reset_color%}%#
# PS1=${debian_chroot:+($debian_chroot)}%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$(prompt_git_info)%}%{$bold_color$fg[blue]%}%~%{$reset_color%}%#



# parse_git_dirty() {
#   [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo '*'
# }
# parse_git_branch() {
#  local branch=$(__git_ps1 "%s")
#  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
# # echo wearedoomed
# }
parse_git_branch() {
    git_status="$(git status 2> /dev/null)"
    pattern="^# On branch ([^[:space:]]*)"
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        state="*"
    fi
    if [[ ${git_status} =~ ${pattern} ]]; then
      branch=${match[1]}
      echo -n "(${branch}${state})"
    fi
}

# Functions for killing text

function send-break {
  marking=0
  zle .send-break
}
zle -N send-break

function accept-line {
  marking=0
  zle .accept-line
}
zle -N accept-line

function set-mark-command {
  marking=1
  zle .set-mark-command
}
zle -N set-mark-command

function backward-kill-word {
  RESTORE=$WORDCHARS
  WORDCHARS=${WORDCHARS//\/}
  if (($marking == 1 ))
  then
    zle .kill-region
  else
    zle .backward-kill-word
  fi
  WORDCHARS=$RESTORE
  marking=0
}
zle -N backward-kill-word

# Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

# If you have LZO compression enabled in your Hadoop cluster and
# compress job outputs with LZOP (not covered in this tutorial):
# Conveniently inspect an LZOP compressed file from the command
# line; run via:
#
# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
#
# Requires installed 'lzop' command.
#
lzohead () {
    hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

# parse_git_branch() {
#     in_wd="$(git rev-parse --is-inside-work-tree 2>/dev/null)" || return
#     test "$in_wd" = true || return
#     state=''
#     git update-index --refresh -q >/dev/null # avoid false positives with diff-index
#     if git rev-parse --verify HEAD >/dev/null 2>&1; then
#         git diff-index HEAD --quiet 2>/dev/null || state='*'
#     else
#         state='#'
#     fi
#     (
#         d="$(git rev-parse --show-cdup)" &&
#         cd "$d" &&
#         test -z "$(git ls-files --others --exclude-standard .)"
#     ) >/dev/null 2>&1 || state="${state}+"
#     branch="$(git symbolic-ref HEAD 2>/dev/null)"
#     test -z "$branch" && branch='<detached-HEAD>'
#     echo "${branch#refs/heads/}${state}"
# }

# PS1=${debian_chroot:+($debian_chroot)}%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$(parse_git_branch)%}%{$bold_color$fg[blue]%}%~%{$reset_color%}%#
#PS1=$(parse_git_branch)%#

##########################################################################
# Various reminders of things I forget...
# (Mostly useful features that I forget to use)
# vared
# =ls turns to /bin/ls
# =(ls) turns to filename (which contains output of ls)
# <(ls) turns to named pipe
# ^X* expand word
# ^[^_ copy prev word
# ^[A accept and hold
# echo $name:r not-extension
# echo $name:e extension
# echo $xx:l lowercase
# echo $name:s/foo/bar/

# Quote current line: M-'
# Quote region: M-"

# Up-case-word: M-u
# Down-case-word: M-l
# Capitilise word: M-c

# kill-region

# expand word: ^X*
# accept-and-hold: M-a
# accept-line-and-down-history: ^O
# execute-named-cmd: M-x
# push-line: ^Q
# run-help: M-h
# spelling correction: M-s

