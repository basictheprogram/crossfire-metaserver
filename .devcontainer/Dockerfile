FROM ubuntu:noble


LABEL maintainer="tanner@real-time.com"

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TZ}

ARG WORKSPACE_FOLDER=${WORKSPACE_FOLDER:-/workspace}
ARG USERNAME=${USERNAME:-vscode}
ARG USER_UID=3000
ARG USER_GID=$USER_UID

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes \
    && apt-get update -qq \
    && apt-get dist-upgrade -qq \
    && apt-get install -qq --no-install-recommends \
        tzdata \
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
    && apt-get autoremove \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME \
    && groupadd --gid $USER_GID $USERNAME || true \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash || true

USER $USERNAME
# WORKDIR $WORKSPACE_FOLDER
# EXPOSE 80
# EXPOSE 443
