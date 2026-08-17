vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/theprimeagen/init.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set('n', '<leader>co', '<cmd>GitConflictChooseOurs<CR>')
vim.keymap.set('n', '<leader>ct', '<cmd>GitConflictChooseTheirs<CR>')
vim.keymap.set('n', '<leader>ch', '<cmd>GitConflictChooseBoth<CR>')
vim.keymap.set('n', '<leader>c0', '<cmd>GitConflictChooseNone<CR>')
vim.keymap.set('n', '<leader>[x', '<cmd>GitConflictPrevConflict<CR>')
vim.keymap.set('n', '<leader>]x', '<cmd>GitConflictNextConflict<CR>')

local function save_and_jslint(opts)
  -- 1. Save buffer
  local save_ok, err = pcall(function()
    vim.cmd(opts.bang and "write!" or "write")
  end)
  if not save_ok then
    vim.notify("Save failed: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  local bufpath = vim.api.nvim_buf_get_name(0)
  if bufpath == "" then
    vim.notify("No file name associated with buffer!", vim.log.levels.WARN)
    return
  end

  -- Updated errorformat matching file:line:col:errnum:message
  local efm = "%f:%l:%c:%n:%m,%f.<node -e>.js:%n:%l:%c:%m,%f:%n:%l:%c:%m"
  local jslint_script = vim.fn.expand("$HOME/.vim/jslint.mjs")

  if vim.fn.filereadable(jslint_script) == 0 then
    vim.notify("JSLint script not found at: " .. jslint_script, vim.log.levels.ERROR)
    return
  end

  -- 2. Run Node
  vim.system(
    { "node", jslint_script, "jslint_wrapper_vim", bufpath },
    { text = true },
    vim.schedule_wrap(function(obj)
      -- Merge stdout and stderr since JSLint outputs warnings on stderr
      local raw_output = (obj.stdout or "") .. (obj.stderr or "")
      local lines = vim.split(raw_output, "\n", { trimempty = true })

      if #lines > 0 then
        -- Send errors into Quickfix list & open Quickfix window
        vim.fn.setqflist({}, "r", { title = "JSLint", lines = lines, efm = efm })
        vim.cmd("cwindow")
        vim.notify("JSLint found " .. #lines .. " issues.", vim.log.levels.WARN)
      else
        -- Clean pass
        vim.fn.setqflist({}, "r", { title = "JSLint", items = {} })
        vim.cmd("cclose")
        vim.notify("JSLint passed cleanly!", vim.log.levels.INFO)
      end
    end)
  )
end

vim.api.nvim_create_user_command("SaveAndJslint", save_and_jslint, { bang = true, nargs = "*" })

local keymap = vim.keymap.set
keymap("n", "<C-s><C-j>", "<cmd>SaveAndJslint<CR>", { silent = true })
keymap("i", "<C-s><C-j>", "<Esc><cmd>SaveAndJslint<CR>", { silent = true })
