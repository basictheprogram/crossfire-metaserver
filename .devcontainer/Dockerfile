# FROM httpd:latest
FROM ubuntu:jammy

LABEL maintainer="tanner@real-time.com"

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ARG WORKSPACE_FOLDER=${WORKSPACE_FOLDER:-/workspaces}
ARG USERNAME=${USERNAME:-you}
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update -qq && \
    apt-get dist-upgrade -qq && \
    apt-get install -qq --no-install-recommends \
    php \
    curl \
    git \
    git-lfs \
    less \
    zip \
    unzip \
    vim-tiny \
    openssh-client \
    pre-commit \
    sudo \
    golang-go && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME

RUN groupadd --gid $USER_GID $USERNAME || true && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash || true

# Switch to the user context for subsequent commands
USER $USERNAME
WORKDIR $WORKSPACE_FOLDER
