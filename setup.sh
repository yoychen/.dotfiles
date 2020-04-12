#!/bin/bash

set -e

if which apt > /dev/null; then
    sudo apt update
    app='apt install -y'; 
fi

# Install `curl`
if ! which curl > /dev/null; then
    sudo $app curl;
fi

# Install and config `git`
if ! which git > /dev/null; then
    sudo $app git;
fi
ln -fs ~/.dotfiles/config/gitconfig ~/.gitconfig

# Install and config `vim`
if ! which vim > /dev/null; then
    sudo $app vim;
fi
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -fs ~/.dotfiles/config/vimrc ~/.vimrc

# Install and config `pyenv`
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Install and config `nvm`
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install and config `docker`
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install and config `docker-compose`
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Config locale
sudo locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8

# Install and config `zsh`
sudo $app zsh
## Disable running `exec zsh` after ohmyzsh installation
## https://github.com/ohmyzsh/ohmyzsh/blob/d53355ab38763c6f637008d019c8e8b98f19b714/tools/install.sh#L24
export RUNZSH=no   
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo $app autojump
ln -fs ~/.dotfiles/config/zshrc ~/.zshrc
