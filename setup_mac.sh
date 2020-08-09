#!/bin/bash

set -e

install_common_utils() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install tmux htop
    brew cask install google-chrome visual-studio-code iterm2
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

install_pyenv() {
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
}

install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

    source ~/.nvm/nvm.sh
    nvm install --lts
}

install_docker() {
    brew cask install docker
}

install_docker_compose() {
    brew install docker-compose
}

install_and_setup_zsh() {
    brew install zsh

    ## Disable running `exec zsh` after ohmyzsh installation
    ## https://github.com/ohmyzsh/ohmyzsh/blob/d53355ab38763c6f637008d019c8e8b98f19b714/tools/install.sh#L24
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    brew install autojump
    ln -fs ~/.dotfiles/config/zshrc ~/.zshrc
}


install_common_utils

# Optional
setup_git
setup_vim
install_pyenv
install_nvm
install_docker
install_docker_compose
install_and_setup_zsh

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
printf "${GREEN}Setup successfully.${NO_COLOR}\n"
