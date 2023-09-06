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

## Workspace Docker Image

You can use docker-compose to build and run the image of my workspace, allowing you to use SSH to login and start your coding.

Steps:

1. Use ssh-keygen to generate you public/private key, and then place your public key in the `.env` file.

   ```
   # in workspace/.env
   SSH_PUBLIC_KEY={your public key}
   ```

2. Move into the `workspace` folder, and then use docker-compose to build and run the image.

   ```sh
   cd workspace
   docker-compose up -d --build
   ```

3. Use SSH to login into the container.

   ```sh
   ssh -o UserKnownHostsFile=/dev/null -p 2222 yoychen@localhost
   ```

   Setting UserKnownHostsFile to '/dev/null' is used to prevent host key verification failure when running another OpenSSH server on the same port.
   You should remove it when you deploy the image to a public server.

### References:

- https://github.com/linuxserver/docker-openssh-server/blob/1e44848fc688abd521d42e5ab3b03f2d9bc81e0b/root/etc/s6-overlay/s6-rc.d/init-openssh-server-config/run#L79
- https://github.com/laradock/laradock/blob/master/workspace/Dockerfile#L54
- https://github.com/laradock/laradock/blob/master/docker-compose.yml#L59
- https://laradock.io/documentation/#access-workspace-via-ssh
