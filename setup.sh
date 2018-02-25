#!/usr/bin/env sh
ln -s $(pwd)/.profile ~/.profile
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
mkdir -p ~/.vim
ln -s $(pwd)/.vim/myUltiSnips ~/.vim/myUltiSnips
