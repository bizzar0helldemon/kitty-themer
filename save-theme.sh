#!/usr/bin/env bash
# ============================================================
#  Save Current Theme — Snapshot your active terminal configs
#  into a shareable theme directory.
#
#  Usage: bash save-theme.sh <theme-name>
#  Example: bash save-theme.sh blade-runner-2049
#
#  This copies your live configs into themes/<theme-name>/
#  so you (or someone else) can restore them later.
# ============================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$1" ]; then
  echo -e "${RED}Usage:${NC} bash save-theme.sh <theme-name>"
  echo "  Example: bash save-theme.sh blade-runner-2049"
  echo "  Theme name should be lowercase with hyphens (no spaces)."
  exit 1
fi

THEME_NAME="$1"
THEME_DIR="$REPO_DIR/themes/$THEME_NAME"

# Validate name
if [[ ! "$THEME_NAME" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo -e "${RED}[ERROR]${NC} Theme name should be lowercase letters, numbers, and hyphens."
  echo "  Example: blade-runner-2049, ghost-in-the-shell, monokai-warm"
  exit 1
fi

# Check if theme already exists
if [ -d "$THEME_DIR" ]; then
  echo -e "${YELLOW}[WARN]${NC} Theme '$THEME_NAME' already exists at $THEME_DIR"
  read -rp "Overwrite? [y/N] " confirm
  [[ "$confirm" =~ ^[Yy]$ ]] || exit 0
fi

mkdir -p "$THEME_DIR"

echo -e "${CYAN}Saving theme: $THEME_NAME${NC}"
echo ""

# Copy configs that exist
SAVED=()

if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
  cp "$HOME/.config/kitty/kitty.conf" "$THEME_DIR/kitty.conf"
  SAVED+=("kitty.conf")
fi

if [ -f "$HOME/.config/starship.toml" ]; then
  cp "$HOME/.config/starship.toml" "$THEME_DIR/starship.toml"
  SAVED+=("starship.toml")
fi

if [ -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  cp "$HOME/.config/fastfetch/config.jsonc" "$THEME_DIR/fastfetch.jsonc"
  SAVED+=("fastfetch.jsonc")
fi

if [ -f "$HOME/.tmux.conf" ]; then
  cp "$HOME/.tmux.conf" "$THEME_DIR/tmux.conf"
  SAVED+=("tmux.conf")
fi

# Extract fzf colors from .zshrc if present
if [ -f "$HOME/.zshrc" ]; then
  FZF_LINE=$(grep -A 20 'FZF_DEFAULT_OPTS' "$HOME/.zshrc" 2>/dev/null | head -20 || true)
  if [ -n "$FZF_LINE" ]; then
    echo "$FZF_LINE" > "$THEME_DIR/fzf-colors.sh"
    SAVED+=("fzf-colors.sh")
  fi

  LS_LINE=$(grep 'LS_COLORS' "$HOME/.zshrc" 2>/dev/null || true)
  if [ -n "$LS_LINE" ]; then
    echo "$LS_LINE" > "$THEME_DIR/ls-colors.sh"
    SAVED+=("ls-colors.sh")
  fi
fi

# Create metadata stub if it doesn't exist
if [ ! -f "$THEME_DIR/metadata.json" ]; then
  AUTHOR=$(whoami)
  DATE=$(date +%Y-%m-%d)
  cat > "$THEME_DIR/metadata.json" << EOF
{
  "name": "$THEME_NAME",
  "description": "",
  "author": "$AUTHOR",
  "created": "$DATE",
  "palette": {}
}
EOF
  echo -e "${YELLOW}  Created metadata.json — edit the description and palette manually${NC}"
  echo "  (or ask Claude Code to fill it in from your config colors)"
fi

echo ""
echo -e "${GREEN}Saved ${#SAVED[@]} files to themes/$THEME_NAME/:${NC}"
for f in "${SAVED[@]}"; do
  echo "  - $f"
done

echo ""
echo -e "${CYAN}Optional next steps:${NC}"
echo "  1. Take a screenshot and save as themes/$THEME_NAME/preview.png"
echo "  2. Edit themes/$THEME_NAME/metadata.json with a description"
echo "  3. git add themes/$THEME_NAME && git commit"
echo ""
