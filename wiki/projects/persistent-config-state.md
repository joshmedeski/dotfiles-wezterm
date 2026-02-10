# Persistent Config State

Save and load config overrides to a JSON file so runtime changes (opacity, wallpaper, color scheme) persist across WezTerm restarts.

- Write config overrides to `~/.wezterm_config` using `wezterm.serde.json_encode`
- Load saved overrides on startup and apply them to the config table
- Persist changes made via events (opacity adjustments, wallpaper selection, color scheme)
