# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a WezTerm terminal emulator configuration written in Lua. WezTerm is configured via `~/.config/wezterm/wezterm.lua` which returns a config table. Full API docs: https://wezterm.org/docs/config/files

## Architecture

**`wezterm.lua`** - Thin entry point. Creates an empty config table, calls `apply_to_config(config)` on each module in `config/`, and returns the config.

**`config/`** - Focused modules, each exporting `apply_to_config(config)` following the `local M = {} ... return M` pattern:
- **`rendering.lua`** - GPU frontend, FPS, power preference settings
- **`font.lua`** - Font family (Maple Mono + Nerd Font fallback), size, line height
- **`appearance.lua`** - Color schemes (Catppuccin Mocha/Latte), dark/light auto-switching, environment variables (BAT_THEME, LC_ALL)
- **`window.lua`** - Padding, decorations, tab bar, blur, opacity settings
- **`keys.lua`** - All key bindings (CMD keys mapped to Neovim commands and tmux prefix sequences)
- **`background.lua`** - Wallpaper + gradient overlay system. Handles static wallpapers from glob, live wallpaper (NOAA satellite download on timer), opacity adjustment events, random wallpaper cycling, appearance change detection, and WALLPAPER user-var
- **`events.lua`** - User-var event handlers for COLOR_SCHEME and ZEN_MODE

**`utils/`** - Reusable helpers following the `local M = {} ... return M` pattern:
- **`helpers.lua`** - `is_dark(appearance)` checks system dark mode, `get_random_entry(tbl)` picks random table element
- **`keys.lua`** - Key binding builders: `cmd_key()`, `cmd_to_tmux_prefix()` (sends Ctrl-b + key), `multiple_actions()` (types a string character-by-character, used for Neovim commands like `:w`)

## Key Patterns

- **Dark/light mode**: `wezterm.gui.get_appearance()` returns "Dark" or "Light". The `helpers.is_dark()` function checks this. Many settings branch on it.
- **Dynamic config**: `window:get_config_overrides()` / `window:set_config_overrides()` pattern is used extensively for runtime changes without restart.
- **User variables**: External tools (like Neovim) set user vars via escape sequences to trigger WezTerm config changes (wallpaper, color scheme, zen mode font size).
- **Tmux integration**: Most CMD+key bindings send `Ctrl-b` (tmux prefix) followed by a tmux key. The tmux prefix is hardcoded as `Ctrl-b`.
- **Type annotations**: Uses `@type Wezterm` and `@type Config` from [wezterm-types](https://github.com/DrKJeff16/wezterm-types) for LSP support.
- **Multiple event handlers**: WezTerm supports multiple handlers for the same event. Both `config/background.lua` and `config/events.lua` register `user-var-changed` handlers for different user variables.

## Development

No build/test/lint commands - this is a Lua config loaded directly by WezTerm. Changes take effect on save (WezTerm watches the config file). Use `wezterm.log_info()` / `wezterm.log_error()` for debugging; logs viewable via `wezterm cli list` or the debug overlay (Ctrl+Shift+L).

Wallpaper images go in `wallpapers/` directory. Animations go in `animations/`.
