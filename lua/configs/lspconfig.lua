-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "lua_ls",
  "rust_analyzer",
  "jsonls",
  "lemminx",
  "pyright",
  "bashls",
  "sqlls",
  "cmake",
  "ltex",
  "racket_langserver",
  "taplo",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--query-driver=/usr/bin/clang++",
    "--header-insertion=never",
    "--clang-tidy",
    "--completion-style=bundled",
    "--fallback-style=Microsoft",
    "--all-scopes-completion",
  },
  init_options = {
    fallbackFlags = { "--std=c++2a" },
    -- fallbackFlags = { "--std=c11" },
  },
}
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

require("ufo").setup {
  open_fold_hl_timeout = 150,
  close_fold_kinds = { "imports", "comment" },
  fold_virt_text_handler = handler,
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  },
  provider_selector = "indent",
  -- provider_selector = function(bufnr, filetype, buftype)
  --     -- if you prefer treesitter provider rather than lsp,
  --     -- return ftMap[filetype] or {'treesitter', 'indent'}
  --     return ftMap[filetype]
  --
  --     -- refer to ./doc/example.lua for detail
  -- end
}
