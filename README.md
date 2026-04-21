# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package   | Installs to `~/`                          | When to use          |
|-----------|-------------------------------------------|----------------------|
| `bash`    | `.bashrc`, `.bash_profile`, `.config/bashrc.d/` | Always          |
| `tmux`    | `.tmux.conf`, `.tmux/plugins/tpm`         | Always               |
| `nvim`    | `.config/nvim/`                           | Always               |
| `scripts` | `.local/bin/loot`                         | Always               |
| `desktop` | `.config/i3/`, `.config/i3blocks/`, `.config/dunst/`, `.config/gtk-3.0/`, `.xinitrc`, `.Xresources`, `.local/bin/` (brightness, volume, screenshot, …) | Linux desktop |
| `mac`     | `.config/alacritty/`, `.config/ghostty/`  | macOS only           |

Directories not yet packaged: `k9s/`, `mpv/`, `nano/`.

## Install

```bash
git clone https://github.com/andersro93/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh            # core only (bash, tmux, nvim, scripts)
./install.sh desktop    # core + desktop
./install.sh mac        # core + mac (macOS only)
./install.sh all        # everything
./install.sh core desktop mac   # combinable
```

The installer:
- Detects OS (macOS / Linux) and distro (apt / dnf / pacman)
- Installs `stow` if missing
- Initialises git submodules (tpm, etc.)
- Installs missing tools: tmux, neovim, starship, ghostty (mac only)
- Runs `stow --restow` for each package (idempotent)

## How GNU Stow works

Stow creates symlinks from your home directory into the package directory, mirroring the structure inside the package. For example:

```
~/.dotfiles/bash/.bashrc  →  stow  →  ~/.bashrc (symlink)
~/.dotfiles/tmux/.tmux.conf  →  stow  →  ~/.tmux.conf (symlink)
```

Each package directory is a mirror of `$HOME`. Files inside it get symlinked at the corresponding path under `$HOME`.

## GitHub Codespaces

GitHub Codespaces automatically runs `install.sh` when you enable dotfiles in your account settings:

**Settings → Codespaces → Dotfiles → Enable**

Point it at this repository. On every new Codespace, `install.sh` runs headlessly and installs the core packages.

## Adding new configs

1. Create a package directory (or reuse an existing one):
   ```
   mkdir -p ~/.dotfiles/mypkg/.config/mytool/
   ```
2. Move your config file into it, mirroring the `$HOME` path:
   ```
   mv ~/.config/mytool/config ~/.dotfiles/mypkg/.config/mytool/config
   ```
3. Stow it:
   ```
   stow --target="$HOME" --dir="$HOME/.dotfiles" mypkg
   ```
4. Add the package to `install.sh` in the appropriate group.
