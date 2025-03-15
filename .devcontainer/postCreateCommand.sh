#!/bin/bash

set -e

timezone_setup() {
    local TZ=${TZ}

    if [ -z "$TZ" ]; then
        echo "==> Timezone not set"
        return
    fi

    echo "==> Setting timezone to: $TZ"
    sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    sudo dpkg-reconfigure -f noninteractive tzdata
}

echo "==> Working directory: $(pwd)"

# Load environment variables from .env file
#
echo "==> Load environment variables from .env file"
if [ -f ".env" ]; then
    set -o allexport
    source ./.env
    set +o allexport
fi

# You are not root here, default is vscode apt will not work without sudo
echo "==> Install linux development tools"

# Timezone setup
#
timezone_setup

# Load environment variables from .env file
#
echo "==> Load environment variables from .env file"
if [ -f ".devcontainer/.env" ]; then
    set -o allexport
    source .devcontainer/.env
    set +o allexport
fi

echo "==> Customize git user configuration"
git config --global core.eol lf
git config --global core.autocrlf false
git config --global http.sslVerify false
git config --global core.editor "code --wait"
git config --global --add safe.directory /workspace

# Customize git user configuration on your branch
#
echo "==> Setting git user.email: '${GIT_USER_EMAIL}'"
git config --global user.email "${GIT_USER_EMAIL}"

# Set git user.name
echo "==> Setting git user.name: '${GIT_USER_NAME}'"
git config --global user.name "${GIT_USER_NAME}"
