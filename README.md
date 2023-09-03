# Yoychen's Dotfiles

It is used to personalize my workspace.

- utils
  - nvm
  - pyenv
  - docker
  - docker-compose
  - zsh (with oh-my-zsh)
- config
  - zshrc
  - gitconfig
  - vimrc

## Usage

Just clone and run the script.

```sh
cd ~
git clone https://github.com/yoychen/.dotfiles.git
.dotfiles/setup.sh
```

## Testing

You can use docker to create a clean environment to test the setup script.

Steps:

1. Create a ubuntu docker container and run the script to create a normal user with sudo permission.

   ```sh
   docker run --rm -it -v $(pwd):/root ubuntu:22.04 /root/prepare_test_environment.sh
   ```

2. In container, follow the steps mentioned in the usage section. Make sure you see the message `Setup successfully.` at the end of the execution.
