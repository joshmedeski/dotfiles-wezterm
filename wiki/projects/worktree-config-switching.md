# Worktree Config Switching

Use git worktrees to test WezTerm config branches in isolation, with symbolic links to swap the active config on demand.

- Use git worktrees so multiple config branches can exist simultaneously
- Add rules to swap which worktree `~/.config/wezterm` points to via symbolic links
- Allow switching the active config branch without disrupting the running terminal
