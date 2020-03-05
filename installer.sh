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
  echo -e '\e[41m>> Error: gvim not installed.\e[49m' >&2
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
  source ~/.bashrc
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
  composer global require dealerdirect/phpcodesniffer-composer-installer
  export PATH="$PATH:$HOME/.config/composer/vendor/bin"
  phpcs --config-set installed_paths ~/.config/composer/vendor/drupal/coder/coder_sniffer
fi

if ! [ -x "$(command -v cmake)" ]; then
  echo -e '\e[41m>> Error: cmake not installed.\e[49m' >&2
  echo 'Installing cmake...'
  sudo apt install cmake
fi

if ! [ -x "$(command -v nvm)" ]; then
  echo -e '\e[41m>> Error: nvm not installed.\e[49m' >&2
  echo 'Installing nvm...'
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  export NVM_DIR="${HOME}/.nvm"
  source ~/.bashrc
fi

if ! [ -x "$(command -v node)" ]; then
  echo -e '\e[41m>> Error: node not installed.\e[49m' >&2
  echo 'Installing node...'
  nvm install v6.11.5
  nvm alias default node
  source ~/.bashrc
fi

if ! [ -x "$(command -v sass-lint)" ]; then
  echo -e '\e[41m>> Error: sass-lint not installed.\e[49m' >&2
  echo 'Installing sass-lint...'
  npm install -g sass-lint
  source ~/.bashrc
fi

echo 'Install font'
mkdir -p ~/.local/share/fonts
cp src/font/*.ttf ~/.local/share/fonts

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

sudo apt install build-essential cmake python3-dev
python3 ~/.vim/bundle/youcompleteme/install.py --clang-completer

source ~/.vimrc

# Install deoplete
(cd ~/.vim/bundle/deoplete-padawan && composer install)

echo 'Installation Success'
