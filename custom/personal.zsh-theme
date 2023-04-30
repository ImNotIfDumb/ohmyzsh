function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}


function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

PROMPT='%(?.%F{243}.%F{red})%h%U${(l:COLUMNS-3-${#%h}:: :)?}%u
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""


#PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
#PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
#
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

# git_prompt_info() {
#   if ! git rev-parse --git-dir > /dev/null 2>&1; then
#     return
#   fi

#   local -a git_info
#   git_info=($(git status --porcelain --branch | awk '
#     NR == 1 { num_ahead = substr($3, 2) };
#     NR == 2 {
#       if (substr($2, 1, 1) != "[") {
#         num_behind=0;
#       } else {
#         num_behind=substr($2, index($2, "[")+1, length($2)-index($2, "[")-1);
#       }
#     }
#     END {
#       if (num_behind) {
#         printf " ↓%s", num_behind
#       }
#       if (num_ahead) {
#         printf " ↑%s", num_ahead
#       }
#     }'
#   ))

#   local branch_name
#   branch_name=$(git symbolic-ref --short HEAD 2> /dev/null)

#   if [ -z "$branch_name" ]; then
#     branch_name=$(git branch -a --contains HEAD | sed -n 1p | awk '{printf $1}')
#     if [ -z "$branch_name" ]; then
#       branch_name=":DetachedHead"
#     fi
#   fi

#   if [ "$branch_name" = "HEAD" ]; then
#     branch_name=":DetachedHead"
#   fi

#   local num_changes_to_commit num_changes_not_staged untracked_changes


#   if [ "$num_changes_to_commit" -eq 0 ] && [ "$num_changes_not_staged" -eq 0 ] && [ "$untracked_changes" -eq 0 ]; then
#     echo "%F{green}✔ %f$branch_name"
#     return
#   fi

#   local to_commit to_stage untracked

#   to_commit=""
#   if [ "$num_changes_to_commit" -gt 0 ]; then
#     to_commit="%F{green}+$num_changes_to_commit%f"
#   fi

#   to_stage=""
#   if [ "$num_changes_not_staged" -gt 0 ]; then
#     to_stage="%F{yellow}~$num_changes_not_staged%f"
#   fi

#   untracked=""
#   if [ "$untracked_changes" -gt 0 ]; then
#     untracked="%F{cyan}!$untracked_changes%f"
#   fi

#   local files_changes
#   files_changes=""
#   files_changes+="${to_commit}"
#   files_changes+="${to_stage}"
#   files_changes+="${untracked}"
#   
#   echo "hello!"
#   # echo "$files_changes"
#   # echo "%F{red}✘ %f$branch_name $files_changes"

#   # if [ "$files_changes" ]; then
#   #     printf " %s|%s %s" "%F{red}" "${files_changes}" "$branch_name"
#   # else
#   #     echo "%F{green}✔ %f$branch_name"
#   # fi
# }

# git_prompt_info() {
#   if ! git rev-parse --git-dir > /dev/null 2>&1; then
#     return
#   fi

#   local -a git_info
#   git_info=($(git status --porcelain --branch | awk '
#     NR == 1 { num_ahead = substr($3, 2) };
#     NR == 2 {
#       if (substr($2, 1, 1) != "[") {
#         num_behind=0;
#       } else {
#         num_behind=substr($2, index($2, "[")+1, length($2)-index($2, "[")-1);
#       }
#     }
#     END {
#       if (num_behind) {
#         printf " ↓%s", num_behind
#       }
#       if (num_ahead) {
#         printf " ↑%s", num_ahead
#       }
#     }'
#   ))

#   local branch_name
#   branch_name=$(git symbolic-ref --short HEAD 2> /dev/null)

#   if [ -z "$branch_name" ]; then
#     branch_name=$(git branch -a --contains HEAD | sed -n 1p | awk '{printf $1}')
#     if [ -z "$branch_name" ]; then
#       branch_name=":DetachedHead"
#     fi
#   fi

#   if [ "$branch_name" = "HEAD" ]; then
#     branch_name=":DetachedHead"
#   fi

#   local num_changes_to_commit num_changes_not_staged untracked_changes

#   num_changes_to_commit=$(git status --porcelain --branch | awk '$1 == "M" { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')
#   num_changes_not_staged=$(git status --porcelain --branch | awk '$1 == "M" && $2 == " " { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')
#   untracked_changes=$(git status --porcelain --branch | awk '$1 == "?" { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')

#   if [ "$num_changes_to_commit" -eq 0 ] && [ "$num_changes_not_staged" -eq 0 ] && [ "$untracked_changes" -eq 0 ]; then
#     echo "%F{green}✔ %f$branch_name"
#     return
#   fi

#   local to_commit to_stage untracked

#   to_commit=""
#   if [ "$num_changes_to_commit" -gt 0 ]; then
#     to_commit="%F{green}+$num_changes_to_commit%f"
#   fi

#   to_stage=""
#   if [ "$num_changes_not_staged" -gt 0 ]; then
#     to_stage="%F{yellow}~$num_changes_not_staged%f"
#   fi

#   untracked=""
#   if [ "$untracked_changes" -gt 0 ]; then
#     untracked="%F{cyan}!$untracked_changes%f"
#   fi

#   local files_changes
#   files_changes=""
#   files_changes+="${to_commit}"
#   files_changes+="${to_stage}"
#   files_changes+="${untracked}"
#   
#   echo "hello!"
#   # echo "$files_changes"
#   # echo "%F{red}✘ %f$branch_name $files_changes"

#   # if [ "$files_changes" ]; then
#   #     printf " %s|%s %s" "%F{red}" "${files_changes}" "$branch_name"
#   # else
#   #     echo "%F{green}✔ %f$branch_name"
#   # fi
# }

function parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function git_prompt_info() {
    local branch_name="$(parse_git_branch)"
    if [ "$branch_name" ]; then
        local files_added_staged=$(git status --porcelain | grep "^A" | wc -l)
        local files_modified_staged=$(git status --porcelain | grep "^M" | wc -l)
        local files_deleted_staged=$(git status --porcelain | grep "^D" | wc -l)
        local files_untracked=$(git status --porcelain | grep "^?" | wc -l)
        local num_changes_to_commit=$(git status --porcelain --branch | awk '$1 == "M" { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')
#   num_changes_not_staged=$(git status --porcelain --branch | awk '$1 == "M" && $2 == " " { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')
#   untracked_changes=$(git status --porcelain --branch | awk '$1 == "?" { cnt += 1 } END { gsub(/^[[:space:]]+|[[:space:]]+$/, "", cnt); print cnt }')
        printf " %s%s:%s:%s %s" "%F{red}" "${files_changes}" "${num_changes_to_commit}" "${num_changes_not_staged}" "$branch_name"

    fi
}

function bracket_start() {
  if [ $(parse_git_branch) ]; then
    printf "["
  fi
}

function bracket_end() {
  if [ $(parse_git_branch) ]; then
    printf "]"
  fi
}
PROMPT='%F{blue}%~%f $(bracket_start)$(git_prompt_info)$(bracket_end) %F{green}>%f '
# PROMPT='%F{blue}%~%f %F{green}>%f '
