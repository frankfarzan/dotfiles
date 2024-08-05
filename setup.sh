#!/usr/bin/env sh
set -eux

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
configs=(.zshrc .vimrc .tmux.conf .oh-my-zsh/custom)
backup=~/.configs.backup/$(date +%s)
echo $backup
mkdir -p $backup

for i in ${configs[@]}; do
	cp -rL ~/$i $backup || true
	ln -sfn $dir/$i ~/$i
done
