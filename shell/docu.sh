## Make it a here-document

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

## from my zshrc:

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


#    # Are we on a remote-tracking branch? -- in +vi-svn-info
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

# ## simplex
# update_current_git_vars(){
# unset __CURRENT_GIT_BRANCH
# unset __CURRENT_GIT_BRANCH_STATUS
# unset __CURRENT_GIT_BRANCH_IS_DIRTY
# 
# local st="$(git status 2>/dev/null)"
# if [[ -n "$st" ]]; then
#   local -a arr
#   arr=(${(f)st})
# 
#   if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
#     __CURRENT_GIT_BRANCH='no-branch'
#   else
#     __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
#   fi
# 
#   if [[ $arr[2] =~ 'Your branch is' ]]; then
#     if [[ $arr[2] =~ 'ahead' ]]; then
#       __CURRENT_GIT_BRANCH_STATUS='ahead'
#     elif [[ $arr[2] =~ 'diverged' ]]; then
#       __CURRENT_GIT_BRANCH_STATUS='diverged'
#     else
#       __CURRENT_GIT_BRANCH_STATUS='behind'
#     fi
#   fi
# 
#   if [[ ! $st =~ 'nothing to commit' ]]; then
#     __CURRENT_GIT_BRANCH_IS_DIRTY='1'
#   fi
# fi
# }
# 
# prompt_git_info(){
# if [ -n "$__CURRENT_GIT_BRANCH" ]; then
#   local s="["
#   s+="$__CURRENT_GIT_BRANCH"
#   case "$__CURRENT_GIT_BRANCH_STATUS" in
#     ahead)
#     s+="↑"
#     ;;
#     diverged)
#     s+="↕"
#     ;;
#     behind)
#     s+="↓"
#     ;;
#   esac
#   if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
#     s+="±"
#   fi
#   s+="]"
# # Add color withing quotes %{$bold_color$fg[blue]%} 
#   printf "%s%s" "" $s
# fi
# }
# 
# chpwd_update_git_vars() {
#   update_current_git_vars
# }
# 
# preexec_update_git_vars() {
#   case "$1" in 
#     git*)
#     __EXECUTED_GIT_COMMAND=1
#     ;;
#   esac
# }
# 
# precmd_update_git_vars(){
#   if [ -n "$__EXECUTED_GIT_COMMAND" ]; then
#     update_current_git_vars
#     unset __EXECUTED_GIT_COMMAND
#   fi
# }
# 
#  number=$(jobs)
#  if [[ $number == "" ]]; then
# .ena.duo' #%{$fg[blue]%}[%j])
# 
# typeset -ga preexec_functions
# typeset -ga precmd_functions
# typeset -ga chpwd_functions
# 
# preexec_functions+='preexec_update_git_vars'
# precmd_functions+='precmd_update_git_vars'
# chpwd_functions+='chpwd_update_git_vars'
# 
# PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '
