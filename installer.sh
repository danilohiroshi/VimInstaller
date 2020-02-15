#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  echo -e '\e[41m>> Error: git not installed.\e[49m' >&2
  echo 'Installing git...'
  sudo apt-get install git.
fi

if ! [ -x "$(command -v vim)" ]; then
  echo -e '\e[41m>> Error: vim 8 not installed.\e[49m' >&2
  echo 'Installing vim...'
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  sudo apt install vim
fi

if ! [ -x "$(command -v gvim)" ]; then
  echo -e '\e[41m>> Error: gvim 8 not installed.\e[49m' >&2
  echo 'Installing gvim...'
  sudo apt-get install vim-gnome
fi

if ! [ -x "$(command -v composer)" ]; then
  echo -e '\e[41m>> Error: composer not installed.\e[49m' >&2
  echo 'Installing composer...'
  sudo apt install composer
fi

if ! [ -x "$(command -v ag)" ]; then
  echo -e '\e[41m>> Error: ag not installed.\e[49m' >&2
  echo 'Installing ag...'
  sudo apt install silversearcher-ag
fi

if ! [ -x "$(command -v ctags)" ]; then
  echo -e '\e[41m>> Error: ctags not installed.\e[49m' >&2
  echo 'Installing ctags...'
  sudo apt install exuberant-ctags
fi

echo 'Install vimrc'
cp src/vimrc ~/.vimrc
cp src/agignore ~/.agignore
cp src/ctags ~/.ctags
mkdir -p ~/.vim
cp src/plugins.vim ~/.vim
cp -r src/after ~/.vim
mkdir -p ~/.vim/bundle
cp -r src/UltiSnips ~/.vim
mkdir -p ~/.vim/undodir

echo 'Install Vundle'
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
echo 'Install Plugins'
vim +PluginInstall +qall

echo 'Installation Success'
