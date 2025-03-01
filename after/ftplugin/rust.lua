local map = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
map("n", "<leader>ca", function()
  vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
map(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { "hover", "actions" }
  end,
  { silent = true, buffer = bufnr }
)

map("n", "<leader>em", function()
  vim.cmd.RustLsp "expandMacro"
end, { silent = true, buffer = bufnr })

map("n", "<leader>mj", function()
  vim.cmd.RustLsp { "moveItem", "down" }
end, { silent = true, buffer = bufnr })

map("n", "<leader>mk", function()
  vim.cmd.RustLsp { "moveItem", "up" }
end, { silent = true, buffer = bufnr })

map("n", "<leader>ej", function()
  vim.cmd.RustLsp { "renderDiagnostic", "cycle" }
end, { silent = true, buffer = bufnr })

map("n", "<leader>oc", function()
  vim.cmd.RustLsp "openCargo"
end, { silent = true, buffer = bufnr })

map("n", "<leader>od", function()
  vim.cmd.RustLsp "openDocs"
end, { silent = true, buffer = bufnr })
