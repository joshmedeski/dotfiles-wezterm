# Start Here

Welcome to the WezTerm config wiki. This is a knowledge base for tracking how the configuration works, what's changed over time, and how to make modifications.

## Quick Navigation

- [Getting Started](guides/getting-started.md) -- How the config works and how to modify it
- [Changelog](changelog/2026-02.md) -- Recent changes and progress
- **Projects**
  - [NOAA GOES Image Viewer](projects/noaa-goes-image-viewer.md) -- Using NOAA satellite imagery as a live terminal background

## Architecture Overview

The config follows a modular pattern:

1. **`wezterm.lua`** -- Entry point. Creates an empty config table and passes it to each module.
2. **`config/`** -- Focused modules that each export `apply_to_config(config)`. This is where all the actual settings live.
3. **`utils/`** -- Reusable helpers shared across modules.

Each module in `config/` is responsible for one area: fonts, appearance, keybindings, background, window settings, etc. When WezTerm loads, the entry point calls each module in sequence and they apply their settings to the config table.

## Using This Wiki

This wiki is an [Obsidian](https://obsidian.md) vault. To use it:

1. Open Obsidian
2. Select "Open folder as vault"
3. Choose the `wiki/` directory

From there you can browse and edit notes, follow links between pages, and use templates to create new documentation.

### Tips

- Click any link to navigate to that note
- Use `Cmd+O` (or `Ctrl+O`) to quick-open any note by name
- Create new notes from templates using the "Insert template" command
- All notes are plain Markdown files, so they work fine outside Obsidian too

## Resources

- [WezTerm Official Docs](https://wezterm.org/docs/config/files)
- [wezterm-types](https://github.com/DrKJeff16/wezterm-types) -- LSP type annotations used in this config
