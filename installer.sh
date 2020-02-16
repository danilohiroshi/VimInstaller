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

if ! [ -x "$(command -v php)" ]; then
  echo -e '\e[41m>> Error: php not installed.\e[49m' >&2
  echo 'Installing drush...'
  sudo apt install php
  sudo apt install php-mbstring
  sudo apt install php-xmlwriter
fi

if ! [ -x "$(command -v composer)" ]; then
  echo -e '\e[41m>> Error: composer not installed.\e[49m' >&2
  echo 'Installing composer...'
  sudo apt install composer
  echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> ~/.bashrc
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

if ! [ -x "$(command -v drush)" ]; then
  echo -e '\e[41m>> Error: drush not installed.\e[49m' >&2
  echo 'Installing drush...'
  composer global require drush/drush:8
fi

if ! [ -x "$(command -v phpcs)" ]; then
  echo -e '\e[41m>> Error: phpcs not installed.\e[49m' >&2
  echo 'Installing phpcs...'
  composer global require squizlabs/php_codesniffer:2.9.1
  composer global require drupal/coder:^8.2.12
  PHP CodeSniffer Config installed_paths set to ~/.config/composer/vendor/drupal/coder/coder_sniffer
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
