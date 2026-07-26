---@type Wezterm
local wezterm = require("wezterm")

local M = {}

M.apply_to_config = function(config, opts)
	wezterm.on("toggle-padding", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if overrides.window_padding then
			overrides.window_padding = nil
		else
			local dim = pane:get_dimensions()
			local cell_width = dim.pixel_width / dim.cols
			local padding = math.floor((dim.pixel_width - (opts.expanded_cols * cell_width)) / 2)
			overrides.window_padding = {
				left = padding,
				right = padding,
				top = opts.padding,
				bottom = 15,
			}
		end
		window:set_config_overrides(overrides)
	end)

	config.window_padding = {
		left = opts.padding,
		right = opts.padding,
		top = opts.padding,
		bottom = 15,
	}

	config.debug_key_events = false
	config.enable_tab_bar = false
	config.native_macos_fullscreen_mode = false
	config.window_close_confirmation = "NeverPrompt"
	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0
	config.macos_window_background_blur = 10
end

return M
