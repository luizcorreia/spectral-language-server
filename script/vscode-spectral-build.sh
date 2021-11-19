#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# prepare
mkdir -p $DIR/../tmp
mkdir -p $DIR/../dist

# clone
cd $DIR/../tmp
git clone --depth=1 git@github.com:stoplightio/vscode-spectral.git vscode-spectral

# pull
cd $DIR/../tmp/vscode-spectral
git clean -fd
git checkout .
git pull --rebase

# npm install
cd $DIR/../tmp/vscode-spectral
yarn add gulp gulp-cli
yarn
yarn compile

# copy to dist
cd $DIR/..
cp -r ./tmp/vscode-spectral/server/out ./dist/spectral-language-server
