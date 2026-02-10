--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

-- Types come from https://github.com/DrKJeff16/wezterm-types

---@type Config
local config = {}

require("config/rendering").apply_to_config(config)
require("config/font").apply_to_config(config)
require("config/appearance").apply_to_config(config)
require("config/window").apply_to_config(config)
require("config/keys").apply_to_config(config)
require("config/events").apply_to_config(config)
require("config/background").apply_to_config(config, {
	wallpapers_glob = os.getenv("HOME") .. "/.config/wezterm/wallpapers/**",
	dark_opacity = 0.85,
	light_opacity = 0.65,
	live = {
		url = "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/2500x1500.jpg",
		refresh_interval = 300,
		dark_opacity = 0.78,
		light_opacity = 0.6,
	},
})

return config

-- TODO: Consolidated dead code and future ideas
--
-- Config saving/loading to file:
--   local config_file_path = os.getenv("HOME") .. "/.wezterm_config"
--   local function save_config_to_file(config)
--     local file = io.open(config_file_path, "w")
--     if file then
--       file:write(wezterm.serde.json_encode(config))
--       file:close()
--     else
--       wezterm.log_error("Failed to open config file for writing")
--     end
--   end
--
-- T_SESSION wallpaper per tmux session:
--   if name == "T_SESSION" then
--     overrides.background = { w.set_tmux_session_wallpaper(value), overlay }
--   end
--
-- DIFF_VIEW font size adjustment for diffview:
--   if name == "DIFF_VIEW" then
--     -- Decrease font on "+N", reset on negative
--   end
--
-- Power preference switching when unplugged:
--   webgpu_power_preference = "LowPower" when on battery
