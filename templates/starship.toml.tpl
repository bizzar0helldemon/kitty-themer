# ============================================================
#  {{THEME_NAME}} — Starship Prompt
#  "{{THEME_QUOTE}}"
# ============================================================
#
# Palette:
#   accent     = "{{ACCENT}}"
#   username   = "{{USERNAME}}"
#   directory  = "{{DIRECTORY}}"
#   info       = "{{INFO}}"
#   success    = "{{SUCCESS}}"
#   error      = "{{ERROR}}"
#   git_branch = "{{GIT_BRANCH}}"
#   muted      = "{{MUTED}}"

format = """
[┌── ](bold {{ACCENT}})\
$os\
$username\
[ ─ ]({{ACCENT}})\
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$rust\
$docker_context\
$cmd_duration\
$fill\
$time\
$line_break\
[└─ ](bold {{ACCENT}})\
$character\
"""

[os]
disabled = false
style = "{{INFO}}"
[os.symbols]
Linux = " "

[username]
show_always = true
style_user = "bold {{USERNAME}}"
format = "[$user]($style) "

[directory]
style = "bold {{DIRECTORY}}"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = " "
style = "{{GIT_BRANCH}}"

[git_status]
style = "{{ERROR}}"

[nodejs]
symbol = " "
style = "{{SUCCESS}}"

[python]
symbol = " "
style = "{{DIRECTORY}}"

[rust]
symbol = " "
style = "{{ERROR}}"

[docker_context]
symbol = " "
style = "{{INFO}}"

[cmd_duration]
min_time = 2_000
style = "{{ACCENT}}"

[fill]
symbol = "─"
style = "{{MUTED}}"

[time]
disabled = false
style = "{{INFO}}"
format = "[$time]($style)"
time_format = "%H:%M"

[character]
success_symbol = "[❯](bold {{SUCCESS}})"
error_symbol = "[❯](bold {{ERROR}})"
