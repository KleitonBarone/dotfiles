#!/bin/bash
set -euo pipefail

# Get file paths
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES_FOLDER=$SCRIPT_PATH/config
FONTS_FOLDER=$SCRIPT_PATH/fonts
BACKUP_DIR="${HOME}/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Flags
FORCE=false
IS_CODESPACES=false

if [ "${CODESPACES:-}" == "true" ]; then
    IS_CODESPACES=true
    FORCE=true
    echo "Running in GitHub Codespaces environment."
fi

if [ "${1:-}" == "--force" ] || [ "${1:-}" == "-f" ]; then
    FORCE=true
fi

echo "Starting dotfiles installation..."

# Install git
if ! command -v git &> /dev/null; then
    echo "Installing git"
    sudo apt install git -y
else
    echo "Git is already installed"
fi

    # Install zsh
    if ! command -v zsh &> /dev/null; then
        echo "Installing zsh"
        sudo apt install zsh -y
        # Set default shell to zsh
        echo "Setting zsh as default shell"
        sudo usermod -s /usr/bin/zsh "${SUDO_USER:-$USER}"
    else
        echo "Zsh is already installed"
    fi

    # Install oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh"
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended --keep-zshrc
    else
        echo "Oh My Zsh is already installed"
    fi

    # Install powerlevel10k
    P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [ ! -d "$P10K_DIR" ]; then
        echo "Installing powerlevel10k"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    else
        echo "Powerlevel10k is already installed"
    fi

    # Install plugins
    ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
    fi

    if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
    fi

# Install FZF
if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "FZF is already installed"
fi

# Install NVM
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "NVM is already installed"
fi

# Install Biome
if ! command -v biome &> /dev/null; then
    echo "Installing Biome"
    curl -L https://github.com/biomejs/biome/releases/download/@biomejs/biome@2.3.8/biome-linux-x64 -o biome
    chmod +x biome
    sudo mv biome /usr/local/bin/biome
else
    echo "Biome is already installed"
fi

# Backup and Link Function
backup_and_link() {
    local src="${1}"
    local dest="${HOME}/$(basename ${src})"

    if [ -e "${dest}" ]; then
        mkdir -p "${BACKUP_DIR}"
        mv "${dest}" "${BACKUP_DIR}/"
        echo "Backed up ${dest} to ${BACKUP_DIR}"
    fi
    ln -sf "${src}" "${dest}"
    echo "Linked ${src} -> ${dest}"
}

echo "Linking dotfiles..."
for f in $(ls -A "${DOTFILES_FOLDER}"); do
    backup_and_link "${DOTFILES_FOLDER}/${f}"
done

# Fonts
copy_font_files() {
    mkdir -p "${HOME}/.fonts"
    for f in $(ls -A "${FONTS_FOLDER}"); do
        cp -f "${FONTS_FOLDER}/${f}" "${HOME}/.fonts/"
    done
    echo "Fonts copied."
}

if [ "$FORCE" = true ]; then
    copy_font_files
else
    read -p "Copy fonts to ~/.fonts? (Y/n) " COPY_FONTS_REPLY
    if [[ $COPY_FONTS_REPLY =~ ^[Nn]$ ]]; then
        echo "Skipped copying font files"
    else
        copy_font_files
    fi
fi

# Git Identity Prompt
if [ "$FORCE" = false ]; then
    CURRENT_NAME=$(git config --global user.name || true)
    if [ -z "$CURRENT_NAME" ]; then
        echo "Git user.name is not set."
        read -p "Enter Git Name: " GIT_NAME
        read -p "Enter Git Email: " GIT_EMAIL
        if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
            git config --global user.name "$GIT_NAME"
            git config --global user.email "$GIT_EMAIL"
            echo "Git identity configured."
        fi
    fi
fi

# Backup Cleanup Prompt
if [ -d "${BACKUP_DIR}" ]; then
    echo "Backup created at ${BACKUP_DIR}"
    if [ "$FORCE" = false ]; then
        read -p "Do you want to DELETE this backup? (y/N) " DELETE_BACKUP
        if [[ $DELETE_BACKUP =~ ^[Yy]$ ]]; then
            rm -rf "${BACKUP_DIR}"
            echo "Backup deleted."
        else
            echo "Backup kept."
        fi
    fi
fi

echo "Finished Successfully."
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
