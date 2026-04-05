// ============================================================
//  {{THEME_NAME}} — System Splash
//  "{{THEME_QUOTE}}"
// ============================================================
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "small",
    "color": {
      "1": "{{LOGO_COLOR_1}}",
      "2": "{{LOGO_COLOR_2}}"
    }
  },
  "display": {
    "separator": " → ",
    "color": {
      "keys": "{{KEY_COLOR}}",
      "title": "{{TITLE_COLOR}}"
    }
  },
  "modules": [
    { "type": "title",    "keyColor": "{{TITLE_COLOR}}" },
    { "type": "separator" },
    { "type": "os",       "keyColor": "{{KEY_COLOR}}" },
    { "type": "kernel",   "keyColor": "{{KEY_COLOR}}" },
    { "type": "uptime",   "keyColor": "{{KEY_COLOR_ALT}}" },
    { "type": "shell",    "keyColor": "{{KEY_COLOR_ALT}}" },
    { "type": "terminal", "keyColor": "{{KEY_COLOR}}" },
    { "type": "cpu",      "keyColor": "{{KEY_COLOR_ALT}}" },
    { "type": "gpu",      "keyColor": "{{KEY_COLOR}}" },
    { "type": "memory",   "keyColor": "{{KEY_COLOR_ALT}}" },
    { "type": "disk",     "keyColor": "{{KEY_COLOR}}" },
    { "type": "separator" },
    { "type": "colors" }
  ]
}
