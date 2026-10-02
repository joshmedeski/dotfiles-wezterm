---@type Wezterm
local wezterm = require("wezterm")
local M = {}

M.active_tab_url = function(browser)
	local success, stdout, stderr = wezterm.run_child_process({
		"osascript",
		"-e",
		'tell application "' .. browser .. '" to return URL of active tab of front window',
	})
	if not success then
		wezterm.log_error("browser.active_tab_url: " .. stderr)
		return nil
	end
	return (stdout:gsub("\n$", ""))
end

M.paste_active_tab_url = function(browser)
	return wezterm.action_callback(function(_, pane)
		local url = M.active_tab_url(browser)
		if url then
			pane:paste(url)
		end
	end)
end

return M
