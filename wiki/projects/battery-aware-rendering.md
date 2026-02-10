# Battery-Aware Rendering

Switch WebGPU power preference to LowPower when the machine is unplugged, reducing GPU energy usage on battery.

- Detect when the machine switches between plugged in and battery power
- Set `webgpu_power_preference = "LowPower"` when on battery
- Set `webgpu_power_preference = "HighPerformance"` when plugged in
