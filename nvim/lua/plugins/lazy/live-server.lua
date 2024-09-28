return {
    "aurum77/live-server.nvim",
    config = function ()
        local status_ok, live_server = pcall(require, "live_server")
        if not status_ok then
            print("failed to setup")
            return
        end
        live_server.setup({
            port = 7077,
            browser_command = "firefox-nightly",
            quiet = false,
            no_css_inject = true,
            install_path = vim.fn.stdpath("data") .. "/live_server/",
        })
    end,
    cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    build = function()
        require("live_server.util").install()
    end,
}
