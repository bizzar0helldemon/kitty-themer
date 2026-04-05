# Kitty Terminal — Keybindings Cheat Sheet

> Quick reference for navigating kitty like a pro.

---

## Windows (Splits)

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Enter` | New window (split) |
| `Ctrl+Shift+]` | Next window |
| `Ctrl+Shift+[` | Previous window |
| `Ctrl+Shift+W` | Close window |

## Tabs

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Right` | Next tab |
| `Ctrl+Shift+Left` | Previous tab |
| `Ctrl+Shift+Q` | Close tab |
| `Ctrl+Shift+.` | Move tab forward |
| `Ctrl+Shift+,` | Move tab backward |

## Font Size

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+=` | Increase font size |
| `Ctrl+Shift+-` | Decrease font size |
| `Ctrl+Shift+0` | Reset font size |

## Opacity (Transparency)

These use a two-key combo: press `Ctrl+Shift+A`, release, then press the second key.

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+A` then `M` | More opaque (+5%) |
| `Ctrl+Shift+A` then `L` | Less opaque (-5%) |
| `Ctrl+Shift+A` then `1` | Fully opaque |
| `Ctrl+Shift+A` then `D` | Reset to default |

## Scrollback

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Up` | Scroll up |
| `Ctrl+Shift+Down` | Scroll down |
| `Ctrl+Shift+Page Up` | Scroll up one page |
| `Ctrl+Shift+Page Down` | Scroll down one page |
| `Ctrl+Shift+Home` | Scroll to top |
| `Ctrl+Shift+End` | Scroll to bottom |
| `Ctrl+Shift+H` | Browse scrollback in pager |

## Clipboard

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |

## Other

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+F5` | Reload kitty.conf (live!) |
| `Ctrl+Shift+F2` | Edit kitty.conf in editor |
| `Ctrl+Shift+F11` | Toggle fullscreen |
| `Ctrl+Shift+U` | Unicode input |
| `Ctrl+Shift+E` | Open URL hints (click links with keyboard) |

---

## Why Kitty?

Kitty is a GPU-accelerated terminal emulator. That means:
- **Fast rendering** — no lag even with heavy output
- **True color support** — all 16 million colors, not just 256
- **Ligatures** — `=>` becomes `⇒`, `!=` becomes `≠` (with the right font)
- **Built-in splits and tabs** — no tmux needed for basic layouts
- **Live config reload** — change colors without restarting
- **Image rendering** — `kitty +kitten icat image.png` shows images in terminal

You CAN still use tmux on top of kitty for session persistence (surviving SSH
disconnects, etc.), but for local work kitty's built-in window management is
often enough.
