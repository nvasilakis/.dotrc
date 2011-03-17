# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nv/.zshrc'

autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
autoload -U colors && colors

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt CORRECTALL
setopt HISTIGNORESPACE
setopt prompt_subst

# End of lines added by compinstall
local _myhosts
if [[ -f $HOME/.ssh/known_hosts ]]; then
  _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
  zstyle ':completion:*' hosts $_myhosts
fi
zstyle ':completion:*:kill:*:processes' command "ps x"

# Handy Alias
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs'
alias f='fg'
alias b='bg'
alias ai='sudo apt-get install'
alias vim='vim -p'
alias -g prj='/media/w7/Projects/'
alias -g cv='/media/w7/Projects/cv/git/cv/'
alias gga='git add'
alias ggc='git commit'
alias ggs='git status'
alias ggl='git log --graph'


# Nice Exports
export EDITOR="vim"

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


typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '
PS1=$'%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:$(prompt_git_info)%{$bold_color$fg[blue]%}%~%{$reset_color%}%#'

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
      echo -n "WayOutWest"
    fi
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

