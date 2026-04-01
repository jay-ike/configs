-- LuaRocks configuration file for Lua 5.4
-- Save this as `~/.config/luarocks/config-5.4.lua`

-- Local installation directory for LuaRocks
rocks_trees = {
    { name = "user", root = home .. "/.luarocks" },
    { name = "system", root = [[/usr/local]] },  -- Adjust for your OS (e.g., C:\Program Files\LuaRocks on Windows)
}

-- LuaRocks server settings (use mirrors if the default is slow)
rocks_servers = {
    [[https://luarocks.org]],
    [[https://luarocks.cn]],  -- Chinese mirror (optional)
    [[https://luarocks-archive.github.io]]  -- Archive mirror (optional)
}

-- Path to Lua interpreter (adjust if needed)
lua_version = "5.4"
lua_interpreter = "lua"

-- Enable/disable verbose mode
verbose = false

-- Enable/disable local cache
local_by_default = true

-- Enable/disable runtime path updates
runtime_path = true

-- Enable/disable plugin mode
plugins = true

-- Path to LuaRocks plugins (optional)
plugins_dir = home .. "/.luarocks/plugins"

-- Enable/disable dependency checking
check_external_deps = true

-- Enable/disable building with C compiler
build_external_deps = true
