echo -n "Loading environment."
. ~/.dotrc/shell/environment.sh
echo ".OK"
echo -n "Loading base configuration.."
. ${DOTRC}/shell/base.sh
echo ".OK"
echo -n "Loading extra configuration.."
. ${DOTRC}/shell/extra.sh
echo ".OK"
echo -n "Loading shell functions.."
. ${DOTRC}/shell/functions.sh
echo ".OK"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
DIRSTACKSIZE=10
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nv/.zshrc'

autoload -Uz compinit
compinit
## case-insensitive (all)artial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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
# Some functions, like _apt and _dpkg, are very slow, so we cache them 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# Setting options
# Advanced spell-checking
setopt CORRECTALL
# Do not append commands that start with space in history stack
setopt HISTIGNORESPACE
# Ignore duplucate history entries
setopt HISTIGNOREDUPS
# Share history between screen windows (tabs)
setopt SHARE_HISTORY
# Append history instead of overwriting
setopt APPEND_HISTORY
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
setopt no_complete_aliases
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
  quark.seas.upenn.edu
  antikythera.vasilak.is
  biglab.seas.upenn.edu
  speclab.seas.upenn.edu
  uranus1.jefferson.edu
  uranus2.jefferson.edu
  gaia1.jefferson.edu
  gaia2.jefferson.edu
  128.91.113.91 # Wharton
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
  nvas@quark.seas.upenn.edu
  nikos@antikythera.vasilak.is
  nvas@biglab.seas.upenn.edu
  nxv009@uranus1.jefferson.edu
  nxv009@uranus2.jefferson.edu
  nxv009@gaia1.jefferson.edu
  nxv009@gaia2.jefferson.edu
  ssh nv@128.91.113.91 # Wharton
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
# tab completion for ssh
zstyle ':completion:*:*:ssh:*' menu yes select
zstyle ':completion:*:ssh:*' force-list always

# vcs_info
# ☡ ∫ S ⨌  for subversion
# ❄ ✺ for Darcs
#  for CVS
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg bzr svn
zstyle ':vcs_info:(hg*|git*|bzr):*' get-revision true
zstyle ':vcs_info:(hg*|git*|bzr):*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}[%f%s%F{5}%F{3}|%F{5}%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(svk|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' unstagedstr "✘"
zstyle ':vcs_info:*' stagedstr "✔"

# ± for git
# zstyle ':vcs_info:git:*' actionformats "[± %a|%8.8i %b %c%u%m]"
zstyle ':vcs_info:*' actionformats "[±|%b %8.8i %{${fg[green]}%}%c%{${fg[red]}%}%u %{${bg[red]}%{${fg_bold[white]}%}%}%a%{$reset_color%}%m]"
zstyle ':vcs_info:git*' formats "[±|%b %8.8i %{${fg[green]}%}%c%{${fg[red]}%}%u%a%{$reset_color%}%m]"
# zstyle ':vcs_info:*' formats "($green%b%u%c$default:$blue%s$default)"
zstyle ':vcs_info:git*+set-message:*' hooks git-stash git-st 

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
        gitstatus=$( echo $gitstatus | sed -e 's/[ \t]*//g' -e 's/^[ \t]*//;s/[ \t]*$//' )

        hook_com[misc]="${(j:/:)gitstatus}${hook_com[misc]}"
    fi
}

# Show count of stashed changes
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
      stashes=$(git stash list 2>/dev/null | wc -l | sed 's/[ \t]*//g')
        hook_com[misc]+="(${stashes} stashed)"
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
}
 
# Creating prompts
PS1=$'%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$bold_color$fg[blue]%}%2~%{$reset_color%}%# '
if [[ "${LACONIC}" != "true" ]]; then
  RPS1=$'${vcs_info_msg_0_}$(show-jobs)'  #%($(ena).[%{$bold_color$fg[blue]%}%j%{$reset_color%}].)
else
  RPS1=$'$(show-jobs)'
fi  
PS4=$'+%N:%i:%_>'

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

# if  using GNU  screen, let  the  zsh tell  screen what  the title  and
# hardstatus of the tab window should be. I grab this with a regex since
# I usually use screen-256-etc.
if [[ $TERM =~ "screen" ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'
  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR "'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'
  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'
  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\
    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
  # called by zsh before executing a command
  function preexec()
  {
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus
  }
  # called by zsh before showing the prompt
  function precmd()
  {
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus
    if [[ "${LACONIC}" != "true" ]]; then
      vcs_info 
    fi
  }
fi
