require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>sw", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch Source and Header" })
map("i", "jk", "<ESC>")
map("n", "<leader>ej", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
map("n", "<leader>ek", vim.diagnostic.goto_prev, { desc = "Goto next diagnostic" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local pantran = require "pantran"
local opts = { noremap = true, silent = true, expr = true }
map("n", "<leader>tr", pantran.motion_translate, opts)
map("n", "<leader>trr", function()
  return pantran.motion_translate() .. "_"
end, opts)
map("x", "<leader>tr", pantran.motion_translate, opts)
--setup mapping to call :LazyGit

map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGIT" }, opts)
