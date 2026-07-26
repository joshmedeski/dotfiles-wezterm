---@type Wezterm
local wezterm = require("wezterm")

local M = {}

local process_to_icon = {
	["fish"] = { wezterm.nerdfonts.md_fish, color = { fg = "#faba4a" } },
	["git"] = { wezterm.nerdfonts.dev_git, color = { fg = "#f05133" } },
	["lazygit"] = { wezterm.nerdfonts.dev_git, color = { fg = "#f05133" } },
	["node"] = { wezterm.nerdfonts.md_nodejs, color = { fg = "#417e38" } },
}

M.apply_to_config = function(config)
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

	tabline.setup({
		options = {
			icons_enabled = true,
			tabs_enabled = true,
			theme_overrides = {},
			section_separators = {
				left = wezterm.nerdfonts.pl_left_hard_divider,
				right = wezterm.nerdfonts.pl_right_hard_divider,
			},
			component_separators = {
				left = wezterm.nerdfonts.pl_left_soft_divider,
				right = wezterm.nerdfonts.pl_right_soft_divider,
			},
			tab_separators = {
				left = wezterm.nerdfonts.pl_left_hard_divider,
				right = wezterm.nerdfonts.pl_right_hard_divider,
			},
		},
		sections = {
			tabline_a = { "workspace" },
			tabline_b = { " " },
			tabline_c = { " " },
			tab_active = {
				"index",
				{ "process", process_to_icon = process_to_icon, padding = { left = 0, right = 1 } },
			},
			tab_inactive = {
				"index",
				{ "process", process_to_icon = process_to_icon, padding = { left = 0, right = 1 } },
			},
			tabline_x = {},
			tabline_y = {},
			tabline_z = {
				"mode",
				fmt = function(str)
					return string.sub(str, 1, 2)
				end,
			},
		},
		extensions = {},
	})

	tabline.apply_to_config(config)
end

return M
