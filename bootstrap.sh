#!/bin/bash

# Set failsafe bash params
set -e

# Get file paths
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES=$SCRIPT_PATH/config

force_link() {
    local src="$1"
    local dest="$HOME/$(basename $src)"
    ln -sf "$src" "$dest"
}

link_files() {
    for f in $(ls -A $DOTFILES); do
        force_link "$DOTFILES/$f"
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    link_files
    echo "Finished Successfully"
    exit 0
fi

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    link_files
    echo "Finished Successfully"
    exit 0
fi

echo "Ended without linking"
exit 0
