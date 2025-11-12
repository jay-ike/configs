local wezterm = require("wezterm")
local fs = require("os")
local M = {}
local wallpapers_path = os.getenv("WALLPAPERS_PATH")
local fallback_dirs = {
    wezterm.home_dir .. "/.config/wezterm/wallpapers"
}

M.is_dark = function()
	return true
end

M.get_random_entry = function(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

M.dir_exists = function (path)
    if path == nil then
        return false
    end
    local handle = io.popen('ls -d "' .. path .. '" 2>/dev/null')
    if handle then
        local result = handle:read("a")
        handle:close()
        return result ~= ""
    end
    return false
end

M.get_wallpaper_glob = function ()
    if M.dir_exists(wallpapers_path) then
        return wallpapers_path .. "/**"
    end
    for _, path in ipairs(fallback_dirs) do
       if M.dir_exists(path) then
            return path .. "/**"
       end
    end
end

return M
