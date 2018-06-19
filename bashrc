export EDITOR="/usr/local/bin/nvim"
export PS1="\w$ "
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
