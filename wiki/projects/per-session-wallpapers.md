# Per-Session Wallpapers

Set a different wallpaper for each tmux session using the T_SESSION user variable, so switching sessions also switches the terminal background.

- Listen for `T_SESSION` user-var-changed event
- Map tmux session name to a wallpaper via `set_tmux_session_wallpaper(value)`
- Override background layers per window when session changes
