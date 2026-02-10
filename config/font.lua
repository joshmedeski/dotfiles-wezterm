---@type Wezterm
local wezterm = require("wezterm")
local M = {}

M.apply_to_config = function(config)
	config.font_size = 20
	config.line_height = 1.0
	config.adjust_window_size_when_changing_font_size = false

	config.font = wezterm.font_with_fallback({
		"Maple Mono",
		-- "CommitMono",
		-- "DengXian",
		-- "Departure Mono",
		-- "GohuFont uni14 Nerd Font Mono",
		-- "Monaspace Argon",
		-- "Monaspace Krypton",
		-- "Monaspace Neon",
		-- "Monaspace Radon",
		-- "Monaspace Xenon",
		-- { family = "Apple Color Emoji" },
		-- { family = "Noto Color Emoji" }, -- default?
		-- NOTE: fallback font for Nerd Font icons
		{ family = "Symbols Nerd Font Mono" },
	})
end

return M
