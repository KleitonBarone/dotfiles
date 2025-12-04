# Kleiton’s Dotfiles

A collection of configuration files and a bootstrap script to set up a productive development environment on Debian-based Linux distributions (Ubuntu, Mint, etc.).

## ✨ Features

- **Shell**: [Zsh](https://www.zsh.org/) configured as the default shell.
- **Framework**: [Oh My Zsh](https://ohmyz.sh/) for managing Zsh configuration.
- **Theme**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a fast, flexible, and informative prompt.
- **Plugins**:
  - `zsh-syntax-highlighting`: Highlights commands as you type.
  - `zsh-autosuggestions`: Suggests commands based on history.
- **Git**: Pre-configured global `.gitconfig`.
- **Fonts**: Installs [Martian Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts) (and others) for proper icon support.

## ⚠️ Prerequisites

This setup is designed for **Debian-based distributions** (e.g., Ubuntu, Linux Mint, Pop!_OS).
The `bootstrap.sh` script uses `apt` for package management.

> **Warning**: If you want to use these dotfiles, it is highly recommended to **fork this repository** and review the code. Remove or modify configurations to suit your needs. Use at your own risk!

## 🚀 Installation

### Option 1: Quick Start (Recommended)

Clone the repository and run the bootstrap script in one go:

```bash
git clone https://github.com/KleitonBarone/dotfiles.git && ./dotfiles/bootstrap.sh
```

### Option 2: Manual Download (No Git)

If you don't have git installed yet or prefer a manual approach:

1.  **Download the repository:**
    ```bash
    wget https://github.com/KleitonBarone/dotfiles/archive/master.tar.gz
    ```

2.  **Extract the archive:**
    ```bash
    tar -xzvf master.tar.gz
    ```

3.  **Run the script:**
    ```bash
    ./dotfiles-master/bootstrap.sh
    ```

## 🛠️ What the Script Does

The `bootstrap.sh` script automates the following:
1.  Installs `git` and `zsh` using `apt`.
2.  Sets `zsh` as the default shell for the current user.
3.  Installs **Oh My Zsh**.
4.  Clones and configures **Powerlevel10k**, **zsh-syntax-highlighting**, and **zsh-autosuggestions**.
5.  Symlinks dotfiles from the `config` directory to your home directory (`~`).
6.  Installs custom fonts to `~/.fonts`.

## 📝 Post-Installation

1.  **Restart your session**: Log out and log back in, or restart your computer to ensure all changes (especially the shell change) take effect.
2.  **Configure Terminal Font**: Open your terminal preferences and set the font to **Martian Mono Nerd Font** (or another Nerd Font installed by the script) to ensure icons in the Powerlevel10k prompt render correctly.
3.  **Powerlevel10k Configuration**: Upon first launch of zsh, the Powerlevel10k configuration wizard should start automatically. If not, run `p10k configure`.

## 👤 Author

[Kleiton Barone](https://github.com/KleitonBarone)
