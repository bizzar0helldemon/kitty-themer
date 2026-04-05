# ============================================================
#  {{THEME_NAME}} — tmux Config
#  "{{THEME_QUOTE}}"
# ============================================================


# ── General ──────────────────────────────────────────────────
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
set -g mouse on
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
set -g history-limit 50000
set -g escape-time 0


# ── Status Bar ───────────────────────────────────────────────
set -g status-position bottom
set -g status-style "bg={{BACKGROUND}},fg={{FOREGROUND}}"
set -g status-left-length 30
set -g status-right-length 50

set -g status-left "#[fg={{INFO}},bold] #{session_name} #[fg={{MUTED}}]| "
set -g status-right "#[fg={{SUCCESS}}] %H:%M #[fg={{MUTED}}]| #[fg={{INFO}}] %d %b "


# ── Window Tabs ──────────────────────────────────────────────
setw -g window-status-format "#[fg={{MUTED}}] #I:#W "
setw -g window-status-current-format "#[fg={{USERNAME}},bold] #I:#W "
setw -g window-status-separator ""


# ── Pane Borders ─────────────────────────────────────────────
set -g pane-border-style "fg={{MUTED}}"
set -g pane-active-border-style "fg={{ACCENT}}"


# ── Messages & Command Line ──────────────────────────────────
set -g message-style "bg={{BACKGROUND}},fg={{USERNAME}},bold"
set -g message-command-style "bg={{BACKGROUND}},fg={{ACCENT}}"


# ── Selection / Copy Mode ────────────────────────────────────
setw -g mode-style "bg={{MUTED}},fg={{FOREGROUND}}"


# ── Bell ─────────────────────────────────────────────────────
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none
