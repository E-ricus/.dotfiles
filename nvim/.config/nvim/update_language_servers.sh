#!/bin/bash
set -e

# Rust Analyzer
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "updating rust-analyzer-linux"
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "updating rust-analyzer-mac"
    OS="mac"
else
    echo "unknown os type"
    exit 2
fi
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$OS -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
# Gopls (requires the go programming language installed)
echo "updating Gopls"
GO111MODULE=on go get golang.org/x/tools/gopls@latest
GO111MODULE=on go get golang.org/x/tools/cmd/goimports
# Pyls (requires pip)
echo "updating Pyls"
pip install python-language-server -U
echo "updating tsserver"
sudo npm install -g typescript-language-server
