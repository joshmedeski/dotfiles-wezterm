local M = {}

M.apply_to_config = function(config)
	config.window_padding = {
		left = 40,
		right = 40,
		top = 40,
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
