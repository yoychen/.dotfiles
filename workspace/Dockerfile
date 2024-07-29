FROM ubuntu:24.10

RUN apt update && apt install -y openssh-server sudo git
RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers

ARG USER=yoychen
ENV USER ${USER}
RUN usermod -l ${USER} ubuntu
RUN usermod -aG sudo ${USER}

USER ${USER}
RUN cd ~ && git clone https://github.com/yoychen/.dotfiles.git && .dotfiles/setup.sh

ARG SSH_PUBLIC_KEY
ENV SSH_PUBLIC_KEY ${SSH_PUBLIC_KEY}
RUN mkdir ~/.ssh && echo ${SSH_PUBLIC_KEY} > ~/.ssh/authorized_keys

USER root
RUN chsh -s /bin/zsh ${USER}

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
