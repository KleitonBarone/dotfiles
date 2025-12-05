# Kleiton’s Dotfiles

A collection of configuration files and a bootstrap script to set up a productive development environment on Linux (Debian, Fedora, Arch) and macOS.

## ✨ Features

- **Shell**: [Zsh](https://www.zsh.org/) configured as the default shell.
- **Framework**: [Oh My Zsh](https://ohmyz.sh/) for managing Zsh configuration.
- **Theme**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a fast, flexible, and informative prompt.
- **Plugins**:
  - `zsh-syntax-highlighting`: Highlights commands as you type.
  - `zsh-autosuggestions`: Suggests commands based on history.
- **Tools**:
  - `fzf`: Command-line fuzzy finder.
  - `nvm`: Node Version Manager.
  - `biome`: Fast formatter and linter for web projects.
- **Git**: Pre-configured global `.gitconfig`.
- **Fonts**: Installs [Martian Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts) (and others) for proper icon support.

## ⚠️ Prerequisites

The `bootstrap.sh` script attempts to detect your OS and use the appropriate package manager.

**Supported Systems:**
- **Debian-based**: Ubuntu, Linux Mint, Pop!_OS, Kali (uses `apt`)
- **RHEL-based**: Fedora, CentOS, AlmaLinux, Rocky (uses `dnf`)
- **Arch-based**: Arch Linux, Manjaro, EndeavourOS (uses `pacman`)
- **macOS**: Uses `brew` (will install Homebrew if missing)

**Requirements:**
- `curl` or `wget` (usually pre-installed)
- `git` (the script will attempt to install it if missing, but it's needed to clone initially)

> **Warning**: If you want to use these dotfiles, it is highly recommended to **fork this repository** and review the code. Remove or modify configurations to suit your needs. Use at your own risk!

## 🚀 Installation

### Option 1: Quick Start (Recommended)

Clone the repository and run the bootstrap script:

```bash
git clone https://github.com/KleitonBarone/dotfiles.git && ./dotfiles/bootstrap.sh
```

### Option 2: Manual Download (No Git)

If you don't have git installed yet:

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

### Flags

- `--force` or `-f`: Force execution, skipping some confirmation prompts (useful for automated setups like Codespaces).

## 🛠️ What the Script Does

The `bootstrap.sh` script automates the following:
1.  Detects the OS and Package Manager.
2.  Installs **Homebrew** (on macOS only).
3.  Installs `git`, `zsh`, and `biome` using the system package manager.
4.  Sets `zsh` as the default shell.
5.  Installs **Oh My Zsh**.
6.  Clones and configures **Powerlevel10k**, **zsh-syntax-highlighting**, and **zsh-autosuggestions**.
7.  Installs **FZF** and **NVM**.
8.  Symlinks dotfiles from the `config` directory to your home directory (`~`), backing up existing ones.
9.  Installs custom fonts (on Linux to `~/.fonts`, on macOS to `~/Library/Fonts`).

## 📝 Post-Installation

1.  **Restart your session**: Log out and log back in, or restart your computer to ensure all changes (especially the shell change) take effect.
2.  **Configure Terminal Font**: Open your terminal preferences and set the font to **Martian Mono Nerd Font** (or another Nerd Font installed by the script) to ensure icons in the Powerlevel10k prompt render correctly.
3.  **Powerlevel10k Configuration**: Upon first launch of zsh, the Powerlevel10k configuration wizard should start automatically. If not, run `p10k configure`.

## 👤 Author

[Kleiton Barone](https://github.com/KleitonBarone)
