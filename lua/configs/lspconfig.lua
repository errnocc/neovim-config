-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local servers = {
  "lua_ls",
  "jsonls",
  "lemminx",
  "pyright",
  "bashls",
  "sqlls",
  "neocmake",
  "ltex",
  "racket_langserver",
  "clangd",
  "asm_ls",
  -- "taplo",
  "gopls",
  -- "harper_ls",
}

local nvlsp = require "nvchad.configs.lspconfig"

vim.lsp.enable(servers)

-- lsps with default config
-- lspconfig.rust_analyzer.setup {
--   filetypes = { "rust" },
--   -- on_attach = function(client, bufnr)
--   --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--   -- end,
--   on_attach = on_attach,
--   settings = {
--     ["rust_analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--       checkOnSave = {
--         command = "clippy",
--       },
--     },
--   },
-- }
--

nvlsp.clangd = {
  cmd = {
    "clangd",
    "--query-driver=/usr/bin/clang++",
    "--header-insertion=never",
    "--clang-tidy",
    "--enable-config",
    "--completion-style=bundled",
    "--fallback-style=Microsoft",
    "--all-scopes-completion",
  },
  init_options = {
    -- fallbackFlags = { "--std=c++23" },
    -- fallbackFlags = { "--std=c11" },
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}

nvlsp.asm_lsp = {
  filetypes = {
    "asm",
    "S",
    "vmasm",
  },
  root_markers = { },
}
