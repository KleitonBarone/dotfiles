#!/bin/bash

# Get file paths
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES=$SCRIPT_PATH/config

# Install git
echo "Installing git"
sudo apt install git -y

# Install zsh
echo "Installing zsh"
sudo apt install zsh -y
# Set default shell to zsh
echo "Setting zsh as default shell"
sudo usermod -s /usr/bin/zsh "${SUDO_USER:-$USER}"

#Install oh-my-zsh
echo "Installing oh-my-zsh"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O "${SCRIPT_PATH}/oh-my-zsh-installer.sh"
sudo chmod +x "${SCRIPT_PATH}/oh-my-zsh-installer.sh"
ZSH= "${SCRIPT_PATH}/oh-my-zsh-installer.sh" --unattended --keep-zshrc

#Install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

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

echo "Linking dot files"
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    link_files
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " OVERRIDE_REPLY
    if [[ $OVERRIDE_REPLY =~ ^[Yy]$ ]]; then
        link_files
    else
        echo "Skipped Linking dot files"
    fi
fi

echo "Finished Successfully"
exit 0
