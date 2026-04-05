# Kitty Themer

**Theme your entire terminal with natural language.**

Tell Claude Code what vibe you want — an anime, a movie, a color mood, a video game — and it generates a cohesive color theme across your entire terminal stack.

```
"Give me a Blade Runner 2049 vibe — dusty oranges and cold teals"
```

That's it. No config file editing. No hex code hunting. Just describe the aesthetic and approve the palette.

---

## What Gets Themed

One conversation themes **5 config files** in harmony:

| Tool | File | What Changes |
|------|------|-------------|
| **Kitty** | `~/.config/kitty/kitty.conf` | Terminal colors, cursor, borders, tabs |
| **Starship** | `~/.config/starship.toml` | Prompt colors, symbols, layout |
| **Fastfetch** | `~/.config/fastfetch/config.jsonc` | System splash colors, quote |
| **fzf** | `~/.zshrc` | Fuzzy finder colors |
| **tmux** | `~/.tmux.conf` | Status bar, pane borders |

Every file stays in sync — same palette, same mood, no clashing colors.

## Quick Start

### 1. Clone and install

```bash
git clone https://github.com/bizzar0helldemon/kitty-themer.git
cd kitty-themer
bash install.sh
```

The installer is **non-destructive** — it checks what you already have, skips what's installed, and never changes your default shell or overwrites existing configs.

### 2. Open Claude Code and describe your vibe

```bash
claude
```

That's the whole interface. Claude reads the project instructions automatically and becomes your theming assistant. Try:

- *"I want an Outlaw Star aesthetic — the red of the XGP, deep space blacks, gold accents"*
- *"Make it look like a Sega Dreamcast boot screen"*
- *"Monokai but warmer, like a coffee shop at night"*
- *"Ghost in the Shell — cold cyborg blues and terminal greens"*

### 3. Approve and apply

Claude generates a 5-7 color palette, shows you the hex values and what inspired each color, then applies it across all your configs. You can go back and forth:

- *"Make the git branch color warmer"*
- *"I don't like that pink, try something more muted"*
- *"Can the background be a little lighter?"*

Press `Ctrl+Shift+F5` in kitty to see changes live.

## Saving and Sharing Themes

```bash
# Save your current theme
bash save-theme.sh my-theme-name

# Restore a saved theme
bash restore-theme.sh my-theme-name
```

Saved themes live in `themes/<name>/` with all the config files, a portable `colors.json`, and metadata. Share them by opening a PR.

## Included Theme

### Edward Netrunner

Inspired by Radical Edward from Cowboy Bebop — warm earth tones with neon accents.

| Role | Color | Hex |
|------|-------|-----|
| Accent | Pink | `#ff6ac1` |
| Username | Orange | `#ff9e64` |
| Directory | Yellow | `#e0af68` |
| Info | Cyan | `#7dcfff` |
| Success | Green | `#9ece6a` |
| Error | Red | `#f7768e` |
| Git Branch | Purple | `#bb9af7` |

## Requirements

- **Ubuntu or Pop!_OS** (other Debian-based distros may work)
- **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)** — the CLI tool from Anthropic

The `install.sh` script handles everything else: kitty, zsh, starship, fastfetch, fzf, tmux, and JetBrainsMono Nerd Font.

## How It Works

The magic is in `CLAUDE.md` — project instructions that turn Claude Code into a theming assistant. When you open Claude Code in this repo, it automatically:

1. Reads `THEME-GUIDE.md` (the complete color map of every config file)
2. Asks what vibe you want
3. Generates a palette with hex values and role names
4. Applies it across all 5 config files using the templates in `templates/`
5. Backs up your existing configs before writing anything

No plugins. No extensions. Just a repo with good instructions.

## Project Structure

```
kitty-themer/
├── CLAUDE.md               # Instructions for Claude Code
├── THEME-GUIDE.md          # Complete color map + design principles
├── install.sh              # Non-destructive dependency installer
├── save-theme.sh           # Snapshot live configs into a theme
├── restore-theme.sh        # Apply a saved theme (with backups)
├── docs/
│   ├── FIRST-STEPS.md      # Gentle kitty intro for newcomers
│   └── KEYBINDINGS.md      # Keyboard shortcut reference
├── templates/
│   ├── kitty.conf.tpl      # Config skeletons with {{PLACEHOLDER}} tokens
│   ├── starship.toml.tpl
│   └── fastfetch.jsonc.tpl
└── themes/
    └── edward-netrunner/   # Example theme
```

## Contributing

Got a theme you're proud of? Save it with `bash save-theme.sh` and open a PR. Include a screenshot as `preview.png` in your theme directory so people can see what it looks like.

## License

MIT
