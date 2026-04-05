# First Steps with Kitty Terminal

> A gentle intro for someone coming from GNOME Terminal, Konsole, or any
> other traditional terminal.

---

## What is Kitty?

Kitty is a modern, GPU-accelerated terminal emulator. It's fast, configurable,
and supports features most terminals don't — like true color, ligatures,
image rendering, and built-in window splits.

If your current terminal feels "fine," kitty will feel fast and pretty.

## Installing

The `install.sh` script in this repo handles this for you, but if you want
to do it manually:

```bash
sudo apt install kitty
```

## Setting Kitty as Your Default Terminal

After installing, you might want kitty to open when you press `Ctrl+Alt+T`
or click "Open Terminal" in your file manager:

```bash
# Set kitty as the default terminal
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
```

You can always switch back:
```bash
sudo update-alternatives --config x-terminal-emulator
```

## The Config File

Kitty is configured through a single text file:

```
~/.config/kitty/kitty.conf
```

Every setting is a simple `key value` pair. No JSON, no XML, no YAML — just
plain text. Comments start with `#`.

**Live reload:** After editing the config, press `Ctrl+Shift+F5` to apply
changes without restarting kitty. This is the killer feature for theming —
you can see color changes instantly.

## Fonts

Kitty works best with a **Nerd Font** — these are fonts patched with extra
icons (file type icons, git symbols, arrows, etc.). The `install.sh` script
installs JetBrainsMono Nerd Font, which is an excellent default.

If you want to try other Nerd Fonts:
1. Browse: https://www.nerdfonts.com/font-downloads
2. Download and unzip to `~/.local/share/fonts/`
3. Run `fc-cache -fv`
4. Update `font_family` in kitty.conf

## Tabs and Splits

Kitty has built-in tabs and window splits — you don't need tmux for basic
multi-pane layouts.

- **New tab:** `Ctrl+Shift+T`
- **New split:** `Ctrl+Shift+Enter`
- **Navigate:** `Ctrl+Shift+[` and `Ctrl+Shift+]`

The tab bar appears at the top with a powerline style (slanted separators).
The active tab is highlighted in your theme's accent color.

## Transparency

Kitty supports background transparency. Your theme sets a default opacity
(usually 92%), and you can adjust it live:

- **More opaque:** `Ctrl+Shift+A` then `M`
- **More transparent:** `Ctrl+Shift+A` then `L`
- **Reset:** `Ctrl+Shift+A` then `D`

> **Note for Wayland/COSMIC users:** Transparency may require running kitty
> under XWayland. If it doesn't work, add `export KITTY_DISABLE_WAYLAND=1`
> to your `.zshrc` or `.bashrc`. The install script does NOT do this
> automatically — it depends on your compositor.

## What's Next?

Once kitty is installed and you're reading this from inside it:

1. Start Claude Code in this repo directory
2. Tell Claude what you want your terminal to look like
3. Claude will generate a custom theme and apply it
4. Press `Ctrl+Shift+F5` to see changes live

See `KEYBINDINGS.md` for the full keyboard shortcut reference.
