# NOAA GOES Image Viewer

NOAA publishes free satellite imagery that auto-refreshes every 5 minutes. This guide walks you through finding an image URL on the NOAA website and using it as a live wallpaper in WezTerm.

## Finding Your Image URL

### 1. Go to the NOAA Satellite Viewer

Open [https://www.star.nesdis.noaa.gov](https://www.star.nesdis.noaa.gov) in your browser.

### 2. Pick a Region

Browse the site and select the region you want. For example, GOES-East Continental U.S. (CONUS) is a great starting point:

[https://www.star.nesdis.noaa.gov/GOES/conus.php?sat=G16](https://www.star.nesdis.noaa.gov/GOES/conus.php?sat=G16)

Other regions are available too -- Full Disk, Mesoscale sectors, GOES-West coverage, etc. Pick whatever area interests you.

### 3. Select GeoColor

Once you're on a region page, select **GeoColor** from the product list. GeoColor composites visible light during the day with infrared and city light maps at night, so it always looks good regardless of time of day.

### 4. Get the CDN URL

When you browse the website, the image URLs you see will have timestamps in them, like:

```
https://cdn.star.nesdis.noaa.gov/GOES19/ABI/CONUS/GEOCOLOR/20260410231_GOES19-ABI-CONUS-GEOCOLOR-625x375.jpg
```

These timestamped URLs point to individual captures and won't update. **Don't use these.**

Instead, NOAA maintains permanent aliases that always return the most recent image. To build one, take the path segments from the timestamped URL and replace the filename with a size:

```
https://cdn.star.nesdis.noaa.gov/{SATELLITE}/ABI/{REGION}/{PRODUCT}/{SIZE}.jpg
```

For the GOES-East CONUS GeoColor example, that gives you:

```
https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/2500x1500.jpg
```

This URL always returns the latest image -- NOAA overwrites it every 5 minutes. You can also use `latest.jpg` instead of a size to get the default resolution.

You can verify it works by checking the headers:

```sh
curl -I "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/CONUS/GEOCOLOR/2500x1500.jpg"
```

Look for `HTTP/2 200` and a recent `last-modified` timestamp.

### Available Sizes

| Size | Approx. file size | Notes |
|---|---|---|
| `1250x750` | ~700 KB | Good for slower connections or smaller screens |
| `2500x1500` | ~3 MB | Good balance for most setups |
| `5000x3000` | ~6 MB | Sharp on high-res / 4K displays |
| `10000x6000` | ~15 MB | Full satellite resolution, very large |

Pick the size that works for your display and network. Swap the size segment in the URL to change it.

## Setting Up the Live Wallpaper

Once you have your CDN URL, set it as the `live.url` in `wezterm.lua`:

```lua
require("config/background").apply_to_config(config, {
  wallpapers_glob = os.getenv("HOME") .. "/.config/wezterm/wallpapers/**",
  dark_opacity = 0.85,
  light_opacity = 0.65,
  live = {
    url = "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/2500x1500.jpg",
    refresh_interval = 300, -- 5 minutes (matches NOAA's update frequency)
    dark_opacity = 0.78,
    light_opacity = 0.6,
  },
})
```

Save the file and WezTerm will start downloading the satellite image. It caches the image at `~/.cache/wezterm/live-wallpaper.jpg` and refreshes it every 5 minutes.

### Config Options

| Option | Default | Description |
|---|---|---|
| `live.url` | *(required)* | The CDN URL you found above |
| `live.refresh_interval` | `300` | Seconds between downloads (5 min matches NOAA's update cycle) |
| `live.dark_opacity` | `0.85` | Overlay opacity in dark mode (higher = darker, easier to read) |
| `live.light_opacity` | `0.65` | Overlay opacity in light mode |

### Adjusting Overlay Opacity

A gradient overlay sits on top of the satellite image so terminal text stays readable. The opacity values control how much of the image shows through:

- **Higher values** (0.8-0.95) -- More overlay, subtle satellite image, easier to read
- **Lower values** (0.5-0.7) -- Less overlay, more visible satellite image

You can also adjust opacity at runtime using the `increase-opacity` and `decrease-opacity` keybindings.

## Debugging

If the wallpaper isn't showing up:

1. Check the URL works: `curl -I "YOUR_URL_HERE"`
2. Check the cache: `ls -la ~/.cache/wezterm/live-wallpaper.jpg`
3. Open the debug overlay with `Ctrl+Shift+L` and look for `live-wallpaper:` log messages

## Resources

- [NOAA GOES Image Viewer](https://www.star.nesdis.noaa.gov) -- Browse all available satellites, regions, and products
- [WezTerm background config](https://wezterm.org/docs/config/lua/config/background) -- Background layer docs
