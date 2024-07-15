#!/bin/bash

set -e

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
git config --global --add safe.directory /workspaces

# Set git user.email
echo "==> Setting git user.email: '${GIT_USER_EMAIL}'"
git config --global user.email "${GIT_USER_EMAIL}"

# Set git user.name
echo "==> Setting git user.name: '${GIT_USER_NAME}'"
git config --global user.name "${GIT_USER_NAME}"
