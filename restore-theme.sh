#!/usr/bin/env bash
# ============================================================
#  Restore Theme — Apply a saved theme from themes/<name>/
#
#  Usage: bash restore-theme.sh <theme-name>
#  Example: bash restore-theme.sh edward-netrunner
#
#  This backs up your current configs, then copies the theme
#  configs into place. Non-destructive — originals are preserved.
# ============================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$1" ]; then
  echo -e "${RED}Usage:${NC} bash restore-theme.sh <theme-name>"
  echo ""
  echo "Available themes:"
  for d in "$REPO_DIR"/themes/*/; do
    [ -d "$d" ] && echo "  - $(basename "$d")"
  done
  exit 1
fi

THEME_NAME="$1"
THEME_DIR="$REPO_DIR/themes/$THEME_NAME"

if [ ! -d "$THEME_DIR" ]; then
  echo -e "${RED}[ERROR]${NC} Theme '$THEME_NAME' not found."
  echo ""
  echo "Available themes:"
  for d in "$REPO_DIR"/themes/*/; do
    [ -d "$d" ] && echo "  - $(basename "$d")"
  done
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo -e "${CYAN}Restoring theme: $THEME_NAME${NC}"
echo ""

# Helper: back up then copy
deploy_config() {
  local src="$1"
  local dest="$2"
  local label="$3"

  if [ ! -f "$src" ]; then
    return
  fi

  # Create destination directory
  mkdir -p "$(dirname "$dest")"

  # Back up existing
  if [ -f "$dest" ]; then
    local backup="${dest}.bak.${TIMESTAMP}"
    cp "$dest" "$backup"
    echo -e "  ${YELLOW}Backed up${NC} $dest -> $(basename "$backup")"
  fi

  cp "$src" "$dest"
  echo -e "  ${GREEN}Deployed${NC} $label -> $dest"
}

deploy_config "$THEME_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf" "kitty.conf"
deploy_config "$THEME_DIR/starship.toml" "$HOME/.config/starship.toml" "starship.toml"
deploy_config "$THEME_DIR/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc" "fastfetch.jsonc"
deploy_config "$THEME_DIR/tmux.conf" "$HOME/.tmux.conf" "tmux.conf"

# fzf and LS_COLORS are trickier — they live inside .zshrc
# We don't auto-deploy those; let Claude Code handle it
if [ -f "$THEME_DIR/fzf-colors.sh" ] || [ -f "$THEME_DIR/ls-colors.sh" ]; then
  echo ""
  echo -e "  ${YELLOW}NOTE:${NC} This theme has fzf/LS_COLORS settings."
  echo "  These live inside .zshrc and are not auto-deployed to avoid"
  echo "  breaking your shell config. Ask Claude Code to apply them:"
  echo '  "Apply the fzf colors from my restored theme"'
fi

echo ""
echo -e "${GREEN}Theme '$THEME_NAME' restored.${NC}"
echo ""
echo "To apply changes:"
echo "  1. Restart kitty (close and reopen)"
echo "  2. Run: source ~/.zshrc"
if command -v tmux &>/dev/null; then
  echo "  3. In tmux: tmux source ~/.tmux.conf"
fi
echo ""
