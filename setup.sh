#!/usr/bin/env sh
set -eu

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
configs=(.zshrc .vimrc .tmux.conf .vim/myUltiSnips .oh-my-zsh/custom)
backup=~/.configs.backup/$(date +%s)
echo $backup
mkdir -p $backup

for i in ${configs[@]}; do
	cp -rL ~/$i $backup || true
	ln -sfn $dir/$i ~/$i
done
