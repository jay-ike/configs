--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local dark_opacity = 0.97
local light_opacity = 0.65

local wallpapers_glob = os.getenv("HOME") .. "/.config/wezterm/wallpapers/**"

local b = require("utils/background")
local cs = require("utils/color_scheme")
local h = require("utils/helpers")
local k = require("utils/keys")
local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action

-- TODO: config saving / loading
-- local config_file_path = os.getenv("HOME") .. "/.wezterm_config"
--
-- local function save_config_to_file(config)
-- 	local file = io.open(config_file_path, "w")
-- 	if file then
-- 		file:write(wezterm.serde.json_encode(config))
-- 		file:close()
-- 	else
-- 		wezterm.log_error("Failed to open config file for writing")
-- 	end
-- end

---@type Config
---@diagnostic disable: missing-fields
local config = {
    -- rendering
    front_end = "WebGpu",
    max_fps = 120,
    -- TODO: change this when unplugged?
    webgpu_power_preference = "HighPerformance",

    -- text
    font_size = 12,
    line_height = 1.2,
    cursor_thickness = 1.0,
    default_cursor_style = 'SteadyUnderline',
    animation_fps = 1,
    cursor_blink_ease_in = 'Constant',
    cursor_blink_ease_out = 'Constant',
    color_scheme_dirs = { "~/.config/wezterm/colors" },
    default_prog = {'sesh', 'connect', 'Projects'},
    -- TODO: add binding to move from forward and backward with my pictures
    background = {
        w.get_wallpaper(wallpapers_glob),
        b.get_background(dark_opacity, light_opacity),
    },

    font = wezterm.font_with_fallback({
        "MonoLisaVariableSC Nerd Font",
        -- "DengXian",
        -- "Departure Mono",
        -- "GohuFont uni14 Nerd Font Mono",
        -- "Monaspace Argon",
        -- "Monaspace Krypton",
        -- "Monaspace Neon",
        -- "Monaspace Radon",
        -- "Monaspace Xenon",
        -- { family = "Apple Color Emoji" },
        -- { family = "Noto Color Emoji" }, -- default?
        { family = "Symbols Nerd Font Mono" },
    }),

    color_scheme = cs.get_color_scheme(),

    window_padding = {
        left = 40,
        right = 40,
        top = 40,
        bottom = 15,
    },

    set_environment_variables = {
        BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
        LC_ALL = "en_GB.UTF-8",
        -- TODO: audit what other variables are needed
    },

    -- general options
    adjust_window_size_when_changing_font_size = false,
    debug_key_events = false,
    enable_tab_bar = false,
    native_macos_fullscreen_mode = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    window_background_opacity = 0,
    macos_window_background_blur = 10,

    -- keys
    keys = {
        k.cmd_key(".", k.multiple_actions(":Zen")),
        k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
        k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),
        k.cmd_key("f", k.multiple_actions(":Grep")),
        k.cmd_key("w", act.SendKey({ mods = "CTRL", key = "q" })),
        -- k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
        -- k.cmd_key("i", k.multiple_actions(":SmartGoTo")),
        -- k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
        -- k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
        -- k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
        -- k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),
        k.cmd_key("O", k.multiple_actions(":GoToSymbol")),
        k.cmd_key("P", k.multiple_actions(":GoToCommand")),
        k.cmd_key("p", k.multiple_actions(":GoToFile")),
        k.cmd_key("q", k.multiple_actions(":qa!")),

        k.cmd_to_tmux_prefix("`", "n"),
        k.cmd_to_tmux_prefix("1", "1"),
        k.cmd_to_tmux_prefix("2", "2"),
        k.cmd_to_tmux_prefix("3", "3"),
        k.cmd_to_tmux_prefix("4", "4"),
        k.cmd_to_tmux_prefix("5", "5"),
        k.cmd_to_tmux_prefix("6", "6"),
        k.cmd_to_tmux_prefix("7", "7"),
        k.cmd_to_tmux_prefix("8", "8"),
        k.cmd_to_tmux_prefix("9", "9"),
        k.cmd_to_tmux_prefix("9", "9"),
        k.cmd_to_tmux_prefix("b", "b"),
        k.cmd_to_tmux_prefix("C", "C"),
        k.cmd_to_tmux_prefix("d", "D"),
        k.cmd_to_tmux_prefix("G", "G"),
        k.cmd_to_tmux_prefix("g", "g"),
        k.cmd_to_tmux_prefix("j", "J"),
        k.cmd_to_tmux_prefix("k", "K"),
        k.cmd_to_tmux_prefix("K", "R"),
        k.cmd_to_tmux_prefix("l", "L"),
        k.cmd_to_tmux_prefix("n", "%"),
        k.cmd_to_tmux_prefix("N", '"'),
        k.cmd_to_tmux_prefix("o", "u"),
        k.cmd_to_tmux_prefix("T", "B"),
        k.cmd_to_tmux_prefix("t", "c"),
        k.cmd_to_tmux_prefix("W", "x"),
        k.cmd_to_tmux_prefix("Y", "Y"),
        k.cmd_to_tmux_prefix("Z", "Z"),
        k.cmd_to_tmux_prefix("z", "z"),

        k.cmd_ctrl_to_tmux_prefix("t", "J"),

        k.cmd_key(
            "R",
            act.Multiple({
                act.SendKey({ key = "\x1b" }), -- escape
                k.multiple_actions(":source %"),
            })
        ),

        k.cmd_key(
            "s",
            act.Multiple({
                act.SendKey({ key = "\x1b" }), -- escape
                k.multiple_actions(":w"),
            })
        ),

        {
            mods = "CMD|SHIFT",
            key = "}",
            action = act.Multiple({
                act.SendKey({ mods = "CTRL", key = "b" }),
                act.SendKey({ key = "n" }),
            }),
        },
        {
            mods = "CMD|SHIFT",
            key = "{",
            action = act.Multiple({
                act.SendKey({ mods = "CTRL", key = "b" }),
                act.SendKey({ key = "p" }),
            }),
        },

        {
            mods = "CTRL",
            key = "Tab",
            action = act.Multiple({
                act.SendKey({ mods = "CTRL", key = "b" }),
                act.SendKey({ key = "n" }),
            }),
        },

        {
            mods = "CTRL|SHIFT",
            key = "Tab",
            action = act.Multiple({
                act.SendKey({ mods = "CTRL", key = "b" }),
                act.SendKey({ key = "n" }),
            }),
        },
        {
            mods = "CMD",
            key = "~",
            action = act.Multiple({
                act.SendKey({ mods = "CTRL", key = "b" }),
                act.SendKey({ key = "p" }),
            }),
        },
    },
}

wezterm.on("user-var-changed", function(window, pane, name, value)
    -- local appearance = window:get_appearance()
    -- local is_dark = appearance:find("Dark")
    local overrides = window:get_config_overrides() or {}
    wezterm.log_info("name", name)
    wezterm.log_info("value", value)

    -- TODO: remove?
    -- if name == "T_SESSION" then
    -- 	local session = value
    -- 	wezterm.log_info("is session", session)
    -- 	overrides.background = {
    -- 		w.set_tmux_session_wallpaper(value),
    -- 		{
    -- 			source = {
    -- 				Gradient = {
    -- 					colors = { "#000000" },
    -- 				},
    -- 			},
    -- 			width = "100%",
    -- 			height = "100%",
    -- 			opacity = 0.95,
    -- 		},
    -- 	}
    -- end

    if name == "WALLPAPER" then
        overrides.background = {
            w.get_path_wallpaper(value),
            b.get_background(dark_opacity, light_opacity),
        }
    end

    if name == "COLOR_SCHEME" then
        print("COLOR_SCHEME")
        print(value)
        overrides.color_scheme = value
    end

    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end

    if name == "DIFF_VIEW" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.DecreaseFontSize, pane)
                number_value = number_value - 1
            end
            -- overrides.background = {
            -- 	w.set_nvim_wallpaper("Diffview.jpeg"),
            --
            -- 	{
            -- 		source = {
            -- 			Gradient = {
            -- 				colors = { "#000000" },
            -- 			},
            -- 		},
            -- 		width = "100%",
            -- 		height = "100%",
            -- 		opacity = 0.95,
            -- 	},
            -- }
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.background = nil
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    window:set_config_overrides(overrides)
end)

return config
