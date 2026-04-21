#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'
log_info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*"; }

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "mac" ;;
        Linux)  echo "linux" ;;
        *)      echo "unknown" ;;
    esac
}

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|raspbian) echo "apt" ;;
            fedora|rhel|centos)     echo "dnf" ;;
            arch|manjaro)           echo "pacman" ;;
            *)                      echo "unknown" ;;
        esac
    else
        echo "unknown"
    fi
}

install_pkg() {
    local pkg="$1"
    local OS; OS=$(detect_os)
    if [ "$OS" = "mac" ]; then
        brew install "$pkg"
    else
        local PM; PM=$(detect_distro)
        case "$PM" in
            apt)    sudo apt-get install -y "$pkg" ;;
            dnf)    sudo dnf install -y "$pkg" ;;
            pacman) sudo pacman -S --noconfirm "$pkg" ;;
            *)      log_warn "Unknown package manager, cannot install $pkg" ;;
        esac
    fi
}

ensure_stow() {
    if ! command -v stow &>/dev/null; then
        log_info "Installing stow..."
        install_pkg stow
    fi
}

ensure_tool() {
    local cmd="$1" pkg="${2:-$1}"
    if ! command -v "$cmd" &>/dev/null; then
        log_info "Installing $pkg..."
        install_pkg "$pkg"
    fi
}

stow_pkg() {
    local pkg="$1"
    log_info "Stowing $pkg..."
    stow --target="$HOME" --dir="$DOTFILES_DIR" --restow "$pkg"
    log_success "Stowed $pkg"
}

parse_args() {
    local -n _groups=$1
    shift
    if [ $# -eq 0 ]; then
        _groups=("core")
        return
    fi
    for arg in "$@"; do
        case "$arg" in
            core|server) _groups+=("core") ;;
            desktop)     _groups+=("core" "desktop") ;;
            mac)         _groups+=("core" "mac") ;;
            all)         _groups+=("core" "desktop" "mac") ;;
            *)           log_warn "Unknown group: $arg (skipping)" ;;
        esac
    done
    # deduplicate
    local seen=()
    local deduped=()
    for g in "${_groups[@]}"; do
        local found=0
        for s in "${seen[@]:-}"; do [ "$s" = "$g" ] && found=1 && break; done
        if [ $found -eq 0 ]; then deduped+=("$g"); seen+=("$g"); fi
    done
    _groups=("${deduped[@]}")
}

main() {
    local OS; OS=$(detect_os)
    log_info "Dotfiles installer — OS: $OS"

    log_info "Initialising submodules..."
    git -C "$DOTFILES_DIR" submodule update --init --recursive

    ensure_stow

    local groups=()
    parse_args groups "$@"

    for group in "${groups[@]}"; do
        case "$group" in
            core)
                ensure_tool tmux
                ensure_tool nvim neovim
                if ! command -v starship &>/dev/null; then
                    log_info "Installing starship..."
                    curl -sS https://starship.rs/install.sh | sh -s -- -y
                fi
                for pkg in bash tmux nvim scripts; do
                    stow_pkg "$pkg"
                done
                ;;
            desktop)
                stow_pkg desktop
                ;;
            mac)
                if [ "$OS" != "mac" ]; then
                    log_warn "mac group requested but OS is $OS — skipping"
                    continue
                fi
                if ! command -v brew &>/dev/null; then
                    log_error "Homebrew not found. Install it first: https://brew.sh"
                    exit 1
                fi
                if ! command -v ghostty &>/dev/null; then
                    log_info "Installing ghostty..."
                    brew install --cask ghostty
                fi
                stow_pkg mac
                ;;
        esac
    done

    log_success "Done! Groups installed: ${groups[*]}"
}

main "$@"
