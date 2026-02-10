---@type Wezterm
local wezterm = require("wezterm")
local h = require("utils/helpers")
local M = {}

local mocha_scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
local latte_scheme = wezterm.get_builtin_color_schemes()["Catppuccin Latte"]

M.apply_to_config = function(config)
	config.color_schemes = {
		["Catppuccin Mocha"] = mocha_scheme,
		["Catppuccin Latte"] = latte_scheme,
	}

	-- TODO: integrate dynamic color switcher (with dark/light mode)
	-- See get_color_scheme() below for iTerm2 random picker
	config.color_scheme = h.is_dark() and "Catppuccin Mocha" or "Catppuccin Latte"

	config.set_environment_variables = {
		BAT_THEME = h.is_dark(nil) and "Catppuccin-mocha" or "Catppuccin-latte",
		LC_ALL = "en_US.UTF-8",
	}
end

-- TODO: dynamic random color scheme picker from iTerm2 repo
-- local function get_color_scheme()
-- 	local color_schemes = {}
-- 	local color_schemes_glob = os.getenv("HOME") .. "/c/iTerm2-Color-Schemes/wezterm/**"
-- 	for _, v in ipairs(wezterm.glob(color_schemes_glob)) do
-- 		local fileName = string.match(v, ".+/([^/]+)%.%w+$")
-- 		table.insert(color_schemes, fileName)
-- 	end
-- 	local color_scheme = h.get_random_entry(color_schemes)
-- 	return color_scheme
-- end

return M
