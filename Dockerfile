################################################################################
# Dockerfile to run Rust stuff.
# A user is created in with the provided USER_ID and GROUP_ID.
################################################################################

FROM rust:1.34.2-stretch

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
