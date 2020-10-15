#!/bin/bash

set -e

if which apt > /dev/null; then
    sudo apt update;
    app='apt install -y'; 
fi

# Config locale
sudo locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8

install_common_utils() {
    sudo $app curl wget tmux htop git vim
}

install_pyenv() {
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
}

install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

    source ~/.nvm/nvm.sh
    nvm install --lts
}

install_docker() {
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
}

install_docker_compose() {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

install_and_setup_zsh() {
    sudo $app zsh

    ## Disable running `exec zsh` after ohmyzsh installation
    ## https://github.com/ohmyzsh/ohmyzsh/blob/d53355ab38763c6f637008d019c8e8b98f19b714/tools/install.sh#L24
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sudo $app autojump
    ln -fs ~/.dotfiles/config/zshrc ~/.zshrc
}

setup_git() {
    ln -fs ~/.dotfiles/config/gitconfig ~/.gitconfig
}

setup_vim() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -fs ~/.dotfiles/config/vimrc ~/.vimrc
    vim +'PlugInstall --sync' +qa
}

install_common_utils

# Optional
install_pyenv
install_nvm
install_docker
install_docker_compose
install_and_setup_zsh
setup_git
setup_vim

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
printf "${GREEN}Setup successfully.${NO_COLOR}\n"
