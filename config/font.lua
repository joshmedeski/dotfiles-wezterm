---@type Wezterm
local wezterm = require("wezterm")
local M = {}

M.apply_to_config = function(config)
	config.font_size = 20
	config.line_height = 1.0
	config.adjust_window_size_when_changing_font_size = false

	-- NOTE: wcwidth table used to decide how many cells a glyph occupies.
	-- Keep this matched to what CLI tools assume, or icons will render fine
	-- but push the following text a column out of alignment.
	config.unicode_version = 14

	-- Never let a wide glyph bleed outside its cell(s).
	config.allow_square_glyphs_to_overflow_width = "Never"

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

		-- NOTE: emoji fallback must come BEFORE the Nerd Font. Nerd Fonts cover
		-- some emoji codepoints (⚙ ⚡ ▶ ✉ …) with monochrome 1-cell glyphs, which
		-- is what makes those emoji look "smaller" than 2-cell color ones.
		{ family = "Apple Color Emoji", assume_emoji_presentation = true },

		-- NOTE: fallback font for Nerd Font icons. Explicitly opted out of emoji
		-- presentation so it only ever serves private-use icon ranges.
		{ family = "Symbols Nerd Font Mono", assume_emoji_presentation = false },
	})
end

return M
