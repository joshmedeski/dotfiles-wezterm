local M = {}

M.apply_to_config = function(config)
	config.front_end = "WebGpu"
	config.max_fps = 120
	-- TODO: change this when unplugged?
	config.webgpu_power_preference = "HighPerformance" -- LowPower | HighPerformance
end

return M
