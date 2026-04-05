# Session Handoff — Kitty Themer

> Context for the next Claude Code session picking up this project.

---

## What This Is

A GitHub repo (public) that lets someone clone it, open it with Claude Code,
and use natural language to create a fully custom terminal theme. The repo is
the interface, Claude Code is the runtime.

**Primary audience:** My brother, running Ubuntu, new to kitty terminal.
**Secondary audience:** Anyone who wants to theme kitty without reading docs.

## What's Done

The full scaffold is built and ready for initial commit:

```
kitty-themer/
├── CLAUDE.md              ← Instructions for Claude Code (theming assistant persona)
├── THEME-GUIDE.md         ← Complete color map of all 5 config files + design principles
├── install.sh             ← Non-destructive Ubuntu bootstrap (kitty, zsh, starship, fonts, etc.)
├── save-theme.sh          ← Snapshot live configs into themes/<name>/
├── restore-theme.sh       ← Apply a saved theme (backs up existing configs first)
├── .gitignore
├── docs/
│   ├── FIRST-STEPS.md     ← Gentle kitty intro for newcomers
│   └── KEYBINDINGS.md     ← Full keyboard shortcut reference
├── templates/
│   ├── kitty.conf.tpl     ← Skeleton with {{PLACEHOLDER}} tokens for theme generation
│   ├── starship.toml.tpl
│   └── fastfetch.jsonc.tpl
└── themes/
    └── edward-netrunner/  ← Working example theme (akhenaten's personal theme)
        ├── kitty.conf
        ├── starship.toml
        ├── fastfetch.jsonc
        ├── colors.json
        └── metadata.json
```

## Key Design Decisions Already Made

1. **Non-destructive installs** — `install.sh` checks before installing, never
   overwrites configs, never changes default shell. This is critical — we do not
   want to break the user's existing workflow.

2. **Themes are saveable/shareable** — `save-theme.sh` snapshots live configs,
   `restore-theme.sh` applies them with automatic backups. Users can PR themes
   back into the repo.

3. **CLAUDE.md is the secret sauce** — it turns Claude Code into a theming
   assistant that reads THEME-GUIDE.md, asks for a vibe, generates a palette,
   and deploys across all config files.

4. **Templates use `{{PLACEHOLDER}}` tokens** — Claude Code fills these in based
   on the generated palette. Role names map to THEME-GUIDE.md color roles.

5. **.zshrc is hands-off except for FZF_DEFAULT_OPTS and LS_COLORS** — we never
   touch aliases, PATH, plugins, or shell logic.

## What Needs To Happen Next

- [ ] Review all files for quality — read through everything with fresh eyes
- [ ] Initial git commit
- [ ] Create GitHub repo (public) and push
- [ ] Consider: a README.md for the GitHub landing page (what people see first)
- [ ] Consider: screenshot of edward-netrunner theme for `themes/edward-netrunner/preview.png`
- [ ] Consider: a tmux.conf template (not yet created)
- [ ] Test `install.sh` mentally against a stock Ubuntu system — any gaps?

## Things NOT In This Repo (On Purpose)

- Full desktop setup scripts (those go in a separate private repo)
- COSMIC/Pop!_OS-specific stuff (Wayland workarounds, .ron color schemes)
- Anything tied to akhenaten's personal machine config
- The `.claude/settings.local.json` from the thumbdrive (gitignored)

## Source Material

The original work lives on a USB thumbdrive at `/media/akhenaten/USB/DesktopSetup/`.
The kitty config was fine-tuned at `~/.config/kitty/kitty.conf`. The THEME-GUIDE.md
was written today and is the core intellectual property of this project — the
natural language theming workflow.
