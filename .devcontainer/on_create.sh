#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y --no-install-recommends tmux
sudo rm -rf /var/lib/apt/lists/*

curl -LsSf https://astral.sh/uv/0.12.6/install.sh | sh
