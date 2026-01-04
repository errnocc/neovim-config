require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.clipboard = "unnamedplus"

-- config neovide
if vim.g.neovide then
  -- vim.o.guifont = "FiraCode Nerd Font Mono:h14" -- text below applies for VimScript
  vim.o.guifont = "CaskaydiaCove NF:h14" -- text below applies for VimScript
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_antialiasing = true
end

-- replace tab wide = 8
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true

-- debug lsp
-- vim.lsp.set_log_level("trace")
vim.lsp.set_log_level "off"
-- vim.opt.dictionary = "/home/lian/.local/dict/american_english.di"
-- vim.opt.complete:append { "k" }

vim.opt.number = false

require("telescope").load_extension "projects"
