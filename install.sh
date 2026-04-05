#!/usr/bin/env bash
# ============================================================
#  Kitty Themer — Dependency Installer
#  Non-destructive bootstrap for Ubuntu/Pop!_OS
#
#  What this does:
#    - Installs kitty terminal (if not present)
#    - Installs JetBrainsMono Nerd Font (if not present)
#    - Installs zsh (if not present) — does NOT change your default shell
#    - Installs starship prompt (if not present)
#    - Installs fastfetch (if not present)
#    - Installs fzf (if not present)
#    - Installs tmux (if not present)
#
#  What this does NOT do:
#    - Overwrite any existing config files
#    - Change your default shell
#    - Modify your .bashrc or .zshrc
#    - Install anything without telling you first
#    - Require root for anything except apt install
#
#  Run as your normal user (NOT root).
# ============================================================

set -e

# ── Colors ──────────────────────────────────────────────────
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

log()     { echo -e "${CYAN}[SETUP]${NC} $1"; }
success() { echo -e "${GREEN}  [OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}  [SKIP]${NC} $1"; }
step()    { echo -e "\n${BOLD}${CYAN}── $1 ──${NC}"; }

echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  Kitty Themer — Dependency Installer                       ${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""
echo -e "  This script installs tools needed for terminal theming."
echo -e "  It will ${BOLD}not${NC} overwrite any of your existing configs."
echo -e "  It will ${BOLD}not${NC} change your default shell."
echo ""

# ── Sanity checks ──────────────────────────────────────────
if [[ "$EUID" -eq 0 ]]; then
  echo -e "${RED}[ERROR]${NC} Do not run as root. Run as your normal user."
  echo "        The script will use sudo only for apt install."
  exit 1
fi

# Detect distro
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO="$ID"
  DISTRO_NAME="$PRETTY_NAME"
else
  DISTRO="unknown"
  DISTRO_NAME="Unknown"
fi

log "Detected: $DISTRO_NAME"

if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "pop" ]]; then
  echo -e "${YELLOW}[WARN]${NC} This installer is designed for Ubuntu/Pop!_OS."
  echo "       It may work on other Debian-based distros but is untested."
  read -rp "Continue anyway? [y/N] " confirm
  [[ "$confirm" =~ ^[Yy]$ ]] || exit 0
fi

# Track what we install for the summary
INSTALLED=()
SKIPPED=()

# ── 1. Update package lists ────────────────────────────────
step "Updating package lists"
sudo apt update -qq
success "Package lists updated"

# ── 2. Kitty terminal ──────────────────────────────────────
step "Kitty Terminal"
if command -v kitty &>/dev/null; then
  KITTY_VER=$(kitty --version 2>/dev/null | head -1)
  warn "Already installed: $KITTY_VER"
  SKIPPED+=("kitty")
else
  log "Installing kitty..."
  sudo apt install -y kitty
  success "Kitty installed"
  INSTALLED+=("kitty")
fi

# ── 3. Zsh ─────────────────────────────────────────────────
step "Zsh"
if command -v zsh &>/dev/null; then
  ZSH_VER=$(zsh --version 2>/dev/null)
  warn "Already installed: $ZSH_VER"
  SKIPPED+=("zsh")
else
  log "Installing zsh..."
  sudo apt install -y zsh
  success "Zsh installed"
  INSTALLED+=("zsh")
  echo ""
  echo -e "  ${YELLOW}NOTE:${NC} Zsh is installed but is ${BOLD}not${NC} your default shell."
  echo "  To make it default (optional): chsh -s \$(which zsh)"
  echo "  You can also just run 'zsh' to try it without committing."
fi

# ── 4. JetBrainsMono Nerd Font ─────────────────────────────
step "JetBrainsMono Nerd Font"
if fc-list 2>/dev/null | grep -qi "JetBrainsMono.*Nerd"; then
  warn "Already installed"
  SKIPPED+=("nerd-font")
else
  log "Installing JetBrainsMono Nerd Font..."
  FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
  mkdir -p "$FONT_DIR"
  TMPZIP=$(mktemp /tmp/jbmono-XXXXXX.zip)
  curl -fL -o "$TMPZIP" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -q -o "$TMPZIP" -d "$FONT_DIR"
  rm -f "$TMPZIP"
  fc-cache -f > /dev/null 2>&1
  success "JetBrainsMono Nerd Font installed to $FONT_DIR"
  INSTALLED+=("nerd-font")
fi

# ── 5. Starship prompt ─────────────────────────────────────
step "Starship Prompt"
if command -v starship &>/dev/null; then
  STAR_VER=$(starship --version 2>/dev/null | head -1)
  warn "Already installed: $STAR_VER"
  SKIPPED+=("starship")
else
  log "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
  success "Starship installed"
  INSTALLED+=("starship")
  echo ""
  echo -e "  ${YELLOW}NOTE:${NC} To activate starship, add this to your shell rc file:"
  echo '  eval "$(starship init zsh)"    # for .zshrc'
  echo '  eval "$(starship init bash)"   # for .bashrc'
fi

# ── 6. Fastfetch ───────────────────────────────────────────
step "Fastfetch"
if command -v fastfetch &>/dev/null; then
  FF_VER=$(fastfetch --version 2>/dev/null | head -1)
  warn "Already installed: $FF_VER"
  SKIPPED+=("fastfetch")
else
  log "Installing fastfetch..."
  # Try apt first (available on newer Ubuntu/Pop)
  if apt-cache show fastfetch &>/dev/null 2>&1; then
    sudo apt install -y fastfetch
  else
    # Fallback: PPA
    log "Not in default repos — adding PPA..."
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update -qq
    sudo apt install -y fastfetch
  fi
  success "Fastfetch installed"
  INSTALLED+=("fastfetch")
fi

# ── 7. fzf ─────────────────────────────────────────────────
step "fzf (Fuzzy Finder)"
if command -v fzf &>/dev/null; then
  FZF_VER=$(fzf --version 2>/dev/null | head -1)
  warn "Already installed: $FZF_VER"
  SKIPPED+=("fzf")
else
  log "Installing fzf..."
  sudo apt install -y fzf
  success "fzf installed"
  INSTALLED+=("fzf")
fi

# ── 8. tmux ────────────────────────────────────────────────
step "tmux"
if command -v tmux &>/dev/null; then
  TMUX_VER=$(tmux -V 2>/dev/null)
  warn "Already installed: $TMUX_VER"
  SKIPPED+=("tmux")
else
  log "Installing tmux..."
  sudo apt install -y tmux
  success "tmux installed"
  INSTALLED+=("tmux")
fi

# ── 9. curl + unzip (needed for font install) ──────────────
# These are almost always present but just in case
for tool in curl unzip; do
  if ! command -v "$tool" &>/dev/null; then
    sudo apt install -y "$tool"
  fi
done

# ── Summary ────────────────────────────────────────────────
echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  Setup Complete                                            ${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""

if [ ${#INSTALLED[@]} -gt 0 ]; then
  echo -e "  ${GREEN}Installed:${NC} ${INSTALLED[*]}"
fi
if [ ${#SKIPPED[@]} -gt 0 ]; then
  echo -e "  ${CYAN}Already had:${NC} ${SKIPPED[*]}"
fi

echo ""
echo -e "  ${BOLD}Next steps:${NC}"
echo ""
echo "  1. Open kitty terminal (if not already in it)"
echo "  2. cd into this repo directory"
echo "  3. Start Claude Code: claude"
echo "  4. Tell Claude what you want your terminal to look like!"
echo ""
echo -e "  ${CYAN}Example:${NC}"
echo '  "I want a Blade Runner 2049 vibe — dusty oranges and cold teals"'
echo ""
echo -e "  ${YELLOW}No config files were modified.${NC}"
echo "  Your existing setup is untouched. Theming happens in the next step."
echo ""
