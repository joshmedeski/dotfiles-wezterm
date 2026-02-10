# Getting Started

This guide covers how the WezTerm config is structured, how to make changes, and how to debug issues.

## Config Architecture

WezTerm loads its configuration from `wezterm.lua`. That file is intentionally thin -- it creates an empty config table and passes it through a series of modules:

```
wezterm.lua
  -> config/rendering.lua    (GPU, FPS, power settings)
  -> config/font.lua         (font family, size, line height)
  -> config/appearance.lua   (color schemes, dark/light switching)
  -> config/window.lua       (padding, decorations, tab bar, opacity)
  -> config/keys.lua         (key bindings)
  -> config/background.lua   (wallpapers, gradients, overlays)
  -> config/events.lua       (user-var event handlers)
```

Each module follows the same pattern:

```lua
local M = {}

function M.apply_to_config(config)
  -- set config values here
end

return M
```

Shared utilities live in `utils/`:

- **`utils/helpers.lua`** -- `is_dark(appearance)` for dark mode detection, `get_random_entry(tbl)` for random selection
- **`utils/keys.lua`** -- Key binding builders for CMD keys, tmux prefix sequences, and multi-action bindings

## Making Changes

1. Open the relevant module in `config/` (or `utils/` for helpers)
2. Edit the Lua code
3. Save the file

That's it. WezTerm watches the config files and automatically reloads when anything changes. No build step, no restart needed.

## Debugging

Two main tools:

- **Logging** -- Add `wezterm.log_info("message")` or `wezterm.log_error("message")` anywhere in the config. View logs with `wezterm cli list` in a terminal.
- **Debug overlay** -- Press `Ctrl+Shift+L` to open WezTerm's built-in debug overlay, which shows logs and other runtime information.

## Key Concepts

### Dark/Light Mode

The config auto-switches between dark and light color schemes based on the system appearance. `wezterm.gui.get_appearance()` returns `"Dark"` or `"Light"`, and the helper function `is_dark()` wraps this check. The appearance module (and others) branch on this to pick appropriate themes.

### User Variables

External tools can set user variables via terminal escape sequences to trigger config changes at runtime. This config uses user variables for:

- **COLOR_SCHEME** -- Override the active color scheme
- **ZEN_MODE** -- Adjust font size for distraction-free editing
- **WALLPAPER** -- Change the active wallpaper

These are handled by event listeners in `config/background.lua` and `config/events.lua`.

### Config Overrides

The `window:set_config_overrides()` API allows changing settings at runtime without editing files. Several event handlers use this pattern to respond to user variable changes dynamically.

### Tmux Integration

Most `Cmd+key` bindings send `Ctrl-b` (the tmux prefix) followed by a key. This means the keybindings work as tmux shortcuts when a tmux session is active.
