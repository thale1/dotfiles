if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

sudo mount -t drvfs '\\codebreaker\temp' /mnt/codebreaker
export PATH+=":$HOME/bin"
export PATH+=":$HOME/.cargo/bin"
