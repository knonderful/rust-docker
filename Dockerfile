################################################################################
# Dockerfile to run Rust stuff.
# A user is created in with the provided USER_ID and GROUP_ID.
################################################################################

FROM ubuntu:18.04

# User ID for the Docker user
ARG USER_ID
# Group ID for the Docker user
ARG GROUP_ID

RUN apt-get -y update && \
    apt-get -y install sudo

# Set up Docker user
ENV USER dockeruser
ENV HOME /home/dockeruser

RUN addgroup --gid $GROUP_ID $USER && \
    adduser $USER --home $HOME --uid $USER_ID --disabled-password --quiet --gid $GROUP_ID && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER $USER

RUN sudo chown -R $USER:$USER $HOME
RUN chmod -R uog+w $HOME

# Install package dependencies.
RUN sudo apt-get update \
    && sudo apt-get install -y \
    apt-utils \
    curl \
    gcc \
    && sudo rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup-init.sh \
    && chmod +x /tmp/rustup-init.sh \
    && sh /tmp/rustup-init.sh -y \
    && rm -rf /tmp/rustup-init.sh
ENV PATH "$PATH:~/.cargo/bin"

# Update the local crate index
RUN ~/.cargo/bin/cargo search

# Install nightly rust.
RUN ~/.cargo/bin/rustup install nightly
