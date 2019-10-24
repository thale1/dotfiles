#!/bin/bash

# Install different dependencies on ubuntu for a cushy setup
# Run with sudo permissions

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install -y \
  zsh \
  tmux \
  neovim \
  python-neovim \
  python3-neovim \
  build-essential \
  cmake \
  python3-dev

cd vim/plugged/youcompleteme

python3 install.py



