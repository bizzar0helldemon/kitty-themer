# ============================================================
#  {{THEME_NAME}} — Kitty Config
#  "{{THEME_QUOTE}}"
# ============================================================


# ── Font ─────────────────────────────────────────────────────
font_family      JetBrainsMono Nerd Font Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        14.0

disable_ligatures never


# ── Unicode Width ────────────────────────────────────────────
narrow_symbols U+2500-U+257F 1
narrow_symbols U+2580-U+259F 1
narrow_symbols U+25A0-U+25FF 1
narrow_symbols U+2600-U+26FF 1
narrow_symbols U+2700-U+27BF 1
narrow_symbols U+00B7 1


# ── Cursor ───────────────────────────────────────────────────
cursor                 {{ACCENT}}
cursor_text_color      {{BACKGROUND}}
cursor_shape           beam
cursor_beam_thickness  1.8
cursor_blink_interval  0.5


# ── Scrollback ───────────────────────────────────────────────
scrollback_lines       50000
wheel_scroll_multiplier 3


# ── Mouse ────────────────────────────────────────────────────
url_color              {{INFO}}
url_style              curly
open_url_with          default
detect_urls            yes
copy_on_select         clipboard


# ── Window Layout ────────────────────────────────────────────
window_padding_width   8
placement_strategy     center
inactive_text_alpha    0.7

active_border_color    {{ACCENT}}
inactive_border_color  {{MUTED}}
bell_border_color      {{DIRECTORY}}
window_border_width    1.5pt


# ── Tab Bar ──────────────────────────────────────────────────
tab_bar_edge           top
tab_bar_style          powerline
tab_powerline_style    slanted
tab_bar_background     {{BACKGROUND}}
active_tab_foreground  {{BACKGROUND}}
active_tab_background  {{USERNAME}}
active_tab_font_style  bold
inactive_tab_foreground {{MUTED}}
inactive_tab_background {{COLOR0}}
inactive_tab_font_style normal
tab_bar_min_tabs       1
tab_title_template     " {index}: {title} "


# ── Background ───────────────────────────────────────────────
background_opacity     0.92
dynamic_background_opacity yes


# ── Audio ────────────────────────────────────────────────────
enable_audio_bell      no
visual_bell_duration   0.1
visual_bell_color      {{ACCENT}}


# ── Keybindings ──────────────────────────────────────────────
# Splits
map ctrl+shift+enter    new_window
map ctrl+shift+]        next_window
map ctrl+shift+[        previous_window

# Tabs
map ctrl+shift+t        new_tab
map ctrl+shift+right    next_tab
map ctrl+shift+left     previous_tab

# Font size (zoom)
map ctrl+shift+equal    change_font_size all +1.0
map ctrl+shift+minus    change_font_size all -1.0
map ctrl+shift+0        change_font_size all 0

# Opacity live adjust
map ctrl+shift+a>m      set_background_opacity +0.05
map ctrl+shift+a>l      set_background_opacity -0.05
map ctrl+shift+a>1      set_background_opacity 1
map ctrl+shift+a>d      set_background_opacity default


# ── Shell ────────────────────────────────────────────────────
shell                  /usr/bin/zsh
editor                 .


# ============================================================
#  {{THEME_NAME}} — Color Scheme
#  {{THEME_DESCRIPTION}}
# ============================================================

# Base colors
foreground             {{FOREGROUND}}
background             {{BACKGROUND}}
selection_foreground   {{BACKGROUND}}
selection_background   {{USERNAME}}

# Normal colors (0-7)
color0                 {{COLOR0}}
color1                 {{ERROR}}
color2                 {{SUCCESS}}
color3                 {{DIRECTORY}}
color4                 {{INFO}}
color5                 {{GIT_BRANCH}}
color6                 {{INFO}}
color7                 {{FOREGROUND}}

# Bright colors (8-15)
color8                 {{MUTED}}
color9                 {{ACCENT}}
color10                {{SUCCESS_BRIGHT}}
color11                {{USERNAME}}
color12                {{INFO_BRIGHT}}
color13                {{GIT_BRANCH_BRIGHT}}
color14                {{INFO_BRIGHT}}
color15                {{FOREGROUND_BRIGHT}}
