vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- config neovide
if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove NF:h14" -- text below applies for VimScript
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_antialiasing = true
end
-- replace tab wide = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- debug lsp
-- vim.lsp.set_log_level("trace")
vim.lsp.set_log_level "off"

