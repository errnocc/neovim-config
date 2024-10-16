-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local inlay = function(_, buf)
  -- require("clangd_extensions.inlay_hints").setup_autocmd()
  -- require("clangd_extensions.inlay_hints").set_inlay_hints()
  local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })
  vim.keymap.set("n", "<leader>lh", function()
    if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
      vim.api.nvim_create_autocmd(
        "InsertEnter",
        { group = group, buffer = buf, callback = require("clangd_extensions.inlay_hints").disable_inlay_hints }
      )
      vim.api.nvim_create_autocmd(
        { "TextChanged", "InsertLeave" },
        { group = group, buffer = buf, callback = require("clangd_extensions.inlay_hints").set_inlay_hints }
      )
    else
      vim.api.nvim_clear_autocmds { group = group, buffer = buf }
    end
  end, { buffer = buf, desc = "[l]sp [h]ints toggle" })
end

local lspconfig = require "lspconfig"
local servers = {
  "lua_ls",
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
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  filetypes = { "rust" },
  -- on_attach = function(client, bufnr)
  --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  -- end,
  on_attach = on_attach,
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

lspconfig.clangd.setup {
  -- on_attach = inlay,
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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
}
