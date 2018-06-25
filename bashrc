export EDITOR="/usr/local/bin/nvim"

# git branch stuff
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\w\$(parse_git_branch)$ "
# added by Miniconda2 installer
export PATH="/Users/thale/miniconda2/bin:$PATH"
alias b="source activate Bison"
alias vim="nvim" # force myself to swap
# git stuff
alias status="git status"
alias branch="git branch"
alias glog="git log"
alias gsu="git sub-update"
alias ..="cd .."
# for thefuck bash corrector
eval $(thefuck --alias)
alias f="fuck"
# for ccache, don't need it b/c of conda?
# export PATH="/usr/local/opt/ccache/libexec:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# History Handling - Erase Duplicates
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=100000
export HISTSIZE=100000

# Add a quit hook that ensures history is appended
shopt -s histappend
PROMPT_COMMAND="history -a"
