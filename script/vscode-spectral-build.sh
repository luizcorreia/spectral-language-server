#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# prepare
mkdir -p "$DIR"/../tmp
mkdir -p "$DIR"/../dist

# clone
cd "$DIR"/../tmp
git clone --depth=1 https://github.com/stoplightio/vscode-spectral.git -b v1.1.0 vscode-spectral

# pull
cd "$DIR"/../tmp/vscode-spectral
git clean -fd
git checkout .
git pull --rebase

# npm install
cd "$DIR"/../tmp/vscode-spectral
yarn config set ignore-engines true
yarn
yarn add -W @rollup/pluginutils
tsc -p server
# copy to dist
cd "$DIR"/..
cp -r ./tmp/vscode-spectral/server/dist ./dist/spectral-language-server
