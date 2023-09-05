#!/bin/bash

set -e

if which apt > /dev/null; then
    sudo apt update;
    app='apt install -y'; 
fi

# Config locale
if which locale-gen > /dev/null; then
    sudo locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8;
fi

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

install_tldr() {
    npm install -g tldr
}

install_docker() {
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
}

install_docker_compose() {
    sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

install_zsh_and_plugins() {
    sudo $app zsh

    ## Disable running `exec zsh` after ohmyzsh installation
    ## https://github.com/ohmyzsh/ohmyzsh/blob/d53355ab38763c6f637008d019c8e8b98f19b714/tools/install.sh#L24
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sudo $app autojump
}

install_vim_plugins() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -fs ~/.dotfiles/config/vimrc ~/.vimrc
    vim +'PlugInstall --sync' +qa
}

link_zsh_config() {
    ln -fs ~/.dotfiles/config/zshrc ~/.zshrc
}

link_git_config() {
    ln -fs ~/.dotfiles/config/gitconfig ~/.gitconfig
}

install_common_utils

# Optional
install_pyenv
install_nvm
install_tldr
install_docker
install_docker_compose
install_zsh_and_plugins
install_vim_plugins
link_zsh_config
link_git_config

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
printf "${GREEN}Setup successfully.${NO_COLOR}\n"
