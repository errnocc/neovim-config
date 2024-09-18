require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>sw", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch Source and Header" })
map("i", "jk", "<ESC>")
map("n", "<leader>ej", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
map("n", "<leader>ek", vim.diagnostic.goto_prev, { desc = "Goto next diagnostic" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
