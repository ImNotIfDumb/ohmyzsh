function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('$(basename $VIRTUAL_ENV:t)') '
}

function collapse_pwd() {
  local home_short="~"
  if [[ "$PWD" == "$HOME" ]]; then
    printf "$home_short"
  elif [[ "$PWD" == "$HOME/"* ]]; then
    printf "$home_short/${PWD#"$HOME/"}"
  else
    printf "${PWD}"
  fi
}

function parse_git_branch() {
  git rev-parse --abbrev-ref HEAD
}

function git_prompt_info() {
  local branch_name="$(parse_git_branch 2>/dev/null)"
  if [ "$branch_name" ]; then
    branch_name=" $branch_name"
    # echo "branch_name=$branch_name"
    local files_added_staged=$(git status --porcelain | grep "^A" | wc -l)
    # echo "files_added_staged=$files_added_staged"
    local files_modified_staged=$(git status --porcelain | grep "^M" | wc -l)
          
    local files_deleted_staged=$(git status --porcelain | grep "^D" | wc -l)
    local untracked_files=$(git status --porcelain | grep "^?" | wc -l)
    local files_modified_unstaged=$(git status --porcelain | grep "^ M" | wc -l)
    local files_deleted_unstaged=$(git status --porcelain | grep "^ D" | wc -l)
    local staged_changes=""
    if [ $files_added_staged -gt 0 ] || [ $files_modified_staged -gt 0 ] || [ $files_deleted_staged -gt 0 ]
    then
      staged_changes="%F{green}+$files_added_staged ~$files_modified_staged -$files_deleted_staged"
    fi
    local unstaged_changes=""
    if [ $untracked_files -gt 0 ] || [ $files_modified_unstaged -gt 0 ] || [ $files_deleted_unstaged -gt 0 ]
    then
      unstaged_changes="%F{red}+$untracked_files ~$files_modified_unstaged -$files_deleted_unstaged"
    fi
    local bar=""
    if [ -n "$staged_changes" ] && [ -n "$unstaged_changes" ]
    then
      bar=" | "
    fi 
    local nothing=""
    if [ -z "$(git status --porcelain)" ]
    then
      nothing='%F{green}≡'
    fi
    echo "%F{green}[$nothing$staged_changes$bar$unstaged_changes%F{green}$branch_name]"
  fi
}

PROMPT='%F{blue}%~%f $(git_prompt_info) >%f '
