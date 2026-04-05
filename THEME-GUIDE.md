# Terminal Theme Guide

> Retheme your entire terminal aesthetic through conversation.
>
> Just tell Claude what vibe you want — an anime, a movie, a color mood,
> whatever — and use this guide as a reference for what gets changed and how.

---

## How to Use This

Open a terminal on the machine you want to retheme. Start Claude Code and say
something like:

> "I want to retheme my terminal to an Outlaw Star aesthetic."

or:

> "Give me a Blade Runner 2049 vibe — all dusty oranges and cold teals."

or even:

> "Make it look like a Sega Dreamcast boot screen."

Claude will read this guide, understand which files to touch, and walk you
through the changes. You can go back and forth — "make the git branch color
warmer", "I don't like that pink, try something more muted" — until it
feels right.

---

## What Gets Themed

There are **5 files** that control the visual identity. They all live in your
home directory and config folders. Here's what each one does and exactly which
values to change:

### 1. Starship Prompt (`~/.config/starship.toml`)

This is the big one — it controls your two-line prompt with all the colored
segments.

**Identity elements** (the theme's "name tag"):
```toml
# Line 1-4: Header comment block — the theme title and tagline
# ============================================================
#  RADICAL EDWARD'S NETRUNNER PROMPT          <-- Theme name
#  "The work which becomes a new genre..."    <-- Quote/tagline
# ============================================================

# The palette documentation block:
[palettes.edward]                              <-- Palette name
# orange  = "#ff9e64"                          <-- Document your colors here
```

**Color map** — every color used in the prompt and what it affects:

| Color hex | Current role | Used by |
|-----------|-------------|---------|
| `#ff6ac1` | **Accent / border** (pink) | Prompt frame `┌──` `└─`, cmd_duration |
| `#ff9e64` | **Username** (orange) | username style, fzf highlight |
| `#e0af68` | **Directory + Python** (yellow) | directory style, python style, fzf prompt |
| `#7dcfff` | **OS icon + Docker + Time** (cyan) | os style, docker style, time style |
| `#9ece6a` | **Success + Node.js** (green) | character success, nodejs style |
| `#f7768e` | **Error + Rust + Git status** (red) | character error, rust style, git_status |
| `#bb9af7` | **Git branch** (purple) | git_branch style, fzf info |
| `#3b4261` | **Fill line** (dark muted) | fill style (the `───` between left and right) |

**Prompt structure** (usually stays the same across themes):
```
┌── OS_ICON username ─ /path/to/dir  on  branch  node v22  took 3s ────── 14:30
└─ ❯
```

The structure (`format = """..."""`) rarely needs to change — just the colors.
But you CAN change the border characters (`┌──`, `└─`) and the prompt symbol
(`❯`) if you want a different feel.

**Symbols** — these use Nerd Font icons. Common swaps:

| Current | Meaning | Alternatives |
|---------|---------|-------------|
| ` ` | Git branch | ` `, ` `, `  ` |
| `❯` | Prompt cursor | `$`, `>`, ``, ``, `>>` |
| `┌──`/`└─` | Border | `╭──`/`╰─`, `┏━━`/`┗━`, `>>`, or remove entirely |
| ` ` | Linux OS | ` `, ` `, `  ` |

---

### 2. Fastfetch System Splash (`~/.config/fastfetch/config.jsonc`)

The system info that appears when you open a new terminal.

**Theme-able values:**

```jsonc
// Header comment — theme identity
// ── RADICAL EDWARD'S SYSTEM SPLASH ─────    <-- Theme name
// "Lesson, lesson..." - Ed                   <-- Character quote

// Logo colors (the small ASCII art)
"logo": {
    "color": {
        "1": "yellow",    // Primary logo color    <-- CHANGE THIS
        "2": "red"        // Secondary logo color  <-- CHANGE THIS
    }
}

// Display colors
"display": {
    "color": {
        "keys": "yellow",  // Label color (OS, CPU, etc.)  <-- CHANGE THIS
        "title": "red"     // Title/header color            <-- CHANGE THIS
    }
}

// Per-module key colors — each line can have its own color:
{ "type": "os",      "keyColor": "yellow"  }   // <-- CHANGE THESE
{ "type": "cpu",     "keyColor": "cyan"    }
{ "type": "memory",  "keyColor": "magenta" }
// etc.
```

**Color values for fastfetch** use named terminal colors, not hex:
`red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`, `black`

You can also use 256-color codes: `"keyColor": "208"` (for orange, etc.)

---

### 3. fzf Fuzzy Finder (`~/.zshrc` — the FZF_DEFAULT_OPTS export)

The popup that appears when you Ctrl+R (history search) or Ctrl+T (file find).

```bash
export FZF_DEFAULT_OPTS="
  --color=bg+:#2a241e    # Selected item background     <-- dark warm
  --color=bg:#1a1612     # Main background              <-- deepest dark
  --color=spinner:#ff6ac1 # Loading spinner             <-- accent color
  --color=hl:#ff9e64     # Highlighted match            <-- warm highlight
  --color=fg:#d4c8b5     # Normal text                  <-- light readable
  --color=header:#7dcfff # Header text                  <-- info color
  --color=info:#bb9af7   # Info line                    <-- secondary accent
  --color=pointer:#ff6ac1 # Selection pointer           <-- accent color
  --color=marker:#9ece6a # Multi-select marker          <-- success color
  --color=fg+:#e8dcc8    # Selected item text           <-- brighter text
  --color=prompt:#e0af68 # Prompt text                  <-- directory color
  --color=hl+:#ff6ac1    # Highlighted match (selected) <-- accent color
  --height=40% --layout=reverse --border=rounded
  --prompt='  '          # Prompt icon (Nerd Font)     <-- can change
"
```

**Key relationships:** fzf colors should echo the starship palette. A good
rule: `pointer` and `spinner` match your accent, `hl` matches your username
color, `info` matches your git branch color.

---

### 4. tmux Status Bar (`~/.tmux.conf`)

The bar at the bottom of tmux sessions.

```bash
# Status bar background and text
set -g status-style "bg=#1a1b26,fg=#a9b1d6"         # <-- bg + default text

# Left: session name
set -g status-left "#[fg=#7aa2f7,bold] ❐ #S "       # <-- session icon + color

# Right: time and date
set -g status-right "#[fg=#9ece6a] %H:%M #[fg=#7aa2f7] %d %b "  # <-- time + date colors

# Active window tab
setw -g window-status-current-style "fg=#7aa2f7,bold" # <-- active tab color

# Pane borders
set -g pane-border-style "fg=#3b4261"                 # <-- inactive border
set -g pane-active-border-style "fg=#7aa2f7"           # <-- active border
```

**The current tmux theme is Tokyo Night.** It doesn't have to match the
starship theme exactly, but it should harmonize. If your starship theme is
warm (oranges/yellows), a cold blue tmux bar might feel off.

---

### 5. LS_COLORS (`~/.zshrc`)

How directories, executables, symlinks etc. are colored in `ls` output.

```bash
export LS_COLORS="di=1;33:ln=36:so=35:pi=33:ex=1;32:bd=34:cd=34:su=31:sg=31:tw=33:ow=33"
```

| Code | Meaning | Current color |
|------|---------|--------------|
| `di=1;33` | Directories | Bold yellow |
| `ln=36` | Symlinks | Cyan |
| `ex=1;32` | Executables | Bold green |
| `so=35` | Sockets | Magenta |

These use ANSI codes: `31`=red, `32`=green, `33`=yellow, `34`=blue,
`35`=magenta, `36`=cyan, `37`=white. Prefix `1;` for bold.

---

## Theme Design Principles

When building a new theme, think about:

1. **Pick 5-7 colors max.** More than that gets noisy. You need:
   - 1 accent (borders, highlights — the "signature" color)
   - 1 warm foreground (username, important text)
   - 1 cool foreground (info, time, secondary)
   - 1 success (green-ish — command worked)
   - 1 error (red-ish — command failed)
   - 1 muted (fill lines, inactive borders)
   - 1 optional secondary accent (git branch, special segments)

2. **Background matters.** Your terminal background sets the stage. Dark warm
   (`#1a1612`) feels different from dark cold (`#1a1b26`). Match your fzf `bg`
   to your terminal's background.

3. **Contrast is king.** If your text colors don't pop against the background,
   nothing else matters. Test with actual code and `ls` output.

4. **Keep the structure.** The prompt layout, fastfetch modules, tmux sections —
   these work well. Just swap colors and identity text.

---

## Example: "Outlaw Star" Retheme

> Here's what you'd say to Claude:
>
> "Retheme my terminal to Outlaw Star. Think Gene Starwind's ship —
> the red of the XGP, deep space blacks, the gold of Melfina's tube,
> and that 90s anime neon. Keep the same prompt structure."

Claude would then derive a palette like:

| Role | Hex | Inspiration |
|------|-----|------------|
| Accent | `#e63946` | XGP-15A II hull red |
| Username | `#f4a261` | Melfina's gold |
| Directory | `#e9c46a` | Navigation console amber |
| Info/Time | `#457b9d` | Deep space steel blue |
| Success | `#2a9d8f` | Caster shell green glow |
| Error | `#e63946` | Alert red |
| Git branch | `#a8dadc` | Starfield ice blue |
| Fill/muted | `#264653` | Dark hull plating |

And update your header:
```toml
# ============================================================
#  OUTLAW STAR — XGP-15A II HELM CONSOLE
#  "You just gotta have the guts to keep going."
# ============================================================
```

Then apply that palette across all 5 files, keeping the layout intact.

---

## Quick Reference: File Locations

| File | Path | What it themes |
|------|------|---------------|
| Starship config | `~/.config/starship.toml` | Prompt colors, symbols, layout |
| Fastfetch config | `~/.config/fastfetch/config.jsonc` | System splash colors, quote |
| Zsh config | `~/.zshrc` | fzf colors, LS_COLORS |
| tmux config | `~/.tmux.conf` | Status bar, pane borders |
| Kitty config | `~/.config/kitty/kitty.conf` | Terminal foreground, background, ANSI colors |
| COSMIC Terminal | Settings > Color Schemes (import `.ron`) | Terminal foreground, background, ANSI colors |
| Color scheme (portable) | `dotfiles/edward-netrunner.json` | Source of truth — convert to Kitty `.conf` or COSMIC `.ron` |

---

## Retheme Checklist

When asking Claude to retheme, it should update ALL of these:

- [ ] `starship.toml` — header, palette docs, all color values
- [ ] `fastfetch config.jsonc` — header quote, logo colors, key colors
- [ ] `.zshrc` — FZF_DEFAULT_OPTS colors, LS_COLORS
- [ ] `.tmux.conf` — status bar, borders, window styles
- [ ] `kitty.conf` — foreground, background, cursor, ANSI color0-15
- [ ] `edward-netrunner.json` — update portable color scheme source
- [ ] `edward-netrunner.ron` — update COSMIC Terminal color scheme
- [ ] This file's "current theme" reference (so the guide stays accurate)
- [ ] Suggest a matching COSMIC terminal background color

After retheme, restart your terminal or run:
```bash
source ~/.zshrc && tmux source ~/.tmux.conf
```
