# Diffview Font Scaling

Adjust the terminal font size when entering diffview in Neovim, making diffs easier to read by temporarily shrinking the font.

- Listen for `DIFF_VIEW` user-var-changed event
- Decrease font size on `+N` values (entering diffview)
- Reset font size on negative values (exiting diffview)
