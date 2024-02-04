#!/bin/bash

# Get file paths
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES_FOLDER=$SCRIPT_PATH/config
FONTS_FOLDER=$SCRIPT_PATH/fonts

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

#Install powerlevel10k zsh theme via oh my zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#Install zsh syntax highlighting via oh my zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Install zsh auto suggestions via oh my zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

force_link() {
    local src="${1}"
    local dest="${HOME}/$(basename ${src})"
    ln -sf "${src}" "${dest}"
}

link_dotfiles() {
    for f in $(ls -A "${DOTFILES_FOLDER}"); do
        force_link "${DOTFILES_FOLDER}/${f}"
    done
}

force_copy_to_fonts() {
    local src="${1}"
    local dest="${HOME}/.fonts/$(basename ${src})"
    cp -f "${src}" "${dest}"
}

copy_font_files() {
    mkdir -p "${HOME}/.fonts"
    for f in $(ls -A "${FONTS_FOLDER}"); do
        force_copy_to_fonts "${FONTS_FOLDER}/${f}"
    done
}

echo "Linking dot files"
if [ "${1}" == "--force" -o "${1}" == "-f" ]; then
    link_dotfiles
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " OVERRIDE_REPLY
    if [[ $OVERRIDE_REPLY =~ ^[Yy]$ ]]; then
        link_dotfiles
    else
        echo "Skipped Linking dot files"
    fi
fi

echo "Copying font files"
if [ "${1}" == "--force" -o "${1}" == "-f" ]; then
    copy_font_files
else
    read -p "This may overwrite existing files in your .fonts directory. Are you sure? (y/N) " OVERRIDE_FONTS_REPLY
    if [[ $OVERRIDE_FONTS_REPLY =~ ^[Yy]$ ]]; then
        copy_font_files
    else
        echo "Skipped copying font files"
    fi
fi

echo "Finished Successfully."
echo "Remember to end current session or reboot to apply changes."
echo "After reboot change terminal font to Martian Mono Nerd Font or another that contain the necessary symbols for the p10k theme."
exit 0
