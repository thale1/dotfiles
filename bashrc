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
# for thefuck bash corrector
eval $(thefuck --alias)
alias f="fuck"
# for ccache, don't need it b/c of conda?
# export PATH="/usr/local/opt/ccache/libexec:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
