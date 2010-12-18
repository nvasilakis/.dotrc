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
alias jj='jobs'
alias f='fg'
alias b='bg'
alias ai='sudo apt-get install'
alias vim='vim -p'

# Nice Exports
export EDITOR="vim"

for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}";

FMT_BRANCH="${PR_GREEN}%b%u%c${PR_RESET}" # e.g. master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"   # e.g. (rebase-i)
FMT_PATH="%R${PR_YELLOW}/%S"              # e.g. ~/repo/subdir

zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"


function precmd {       
    vcs_info 'prompt'          
} 

function lprompt {
    local brackets=$1
    local color1=$2  
    local color2=$3  
                     
    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}"          
                                                             
    local git='$vcs_info_msg_0_'                           
    local cwd="${color2}%B%1~%b"

    PROMPT="${PR_RESET}${bracket_open}${git}${cwd}${bracket_close}%# ${PR_RESET}"
}                                                                                        

function rprompt {
    local brackets=$1
    local color1=$2  
    local color2=$3  
                     
    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}${PR_RESET}"
    local colon="${color1}:"                                
    local at="${color1}@${PR_RESET}"                        
                                                            
    local user_host="${color2}%n${at}${color2}%m"                    
    local vcs_cwd='${${vcs_info_msg_1_%%.}/$HOME/~}'        
    local cwd="${color2}%B%20<..<${vcs_cwd}%<<%b"
    local inner="${user_host}${colon}${cwd}"

    RPROMPT="${PR_RESET}${bracket_open}${inner}${bracket_close}${PR_RESET}"
}

lprompt '[]' $BR_BRIGHT_BLACK $PR_WHITE
rprompt '()' $BR_BRIGHT_BLACK $PR_WHITE










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

PS1=${debian_chroot:+($debian_chroot)}%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$(parse_git_branch)%}%{$bold_color$fg[blue]%}%~%{$reset_color%}%#
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

