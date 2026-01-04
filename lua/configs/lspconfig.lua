-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = {
  lua_ls = {},
  json_ls = {},
  lemminx = {},
  pyright = {},
  bashls = {},
  sqlls = {},
  neocmake = {},
  ltex = {},
  clangd = {
    cmd = {
      "clangd",
      -- "--query-driver=/usr/bin/clang++",
      "--header-insertion=never",
      "--clang-tidy",
      "--enable-config",
      "--completion-style=bundled",
      "--fallback-style=Microsoft",
      "--all-scopes-completion",
      "--malloc-trim",
      "--background-index",
      "--pch-storage=memory",
    },
    init_options = {
      -- fallbackFlags = { "--std=c++23" },
      -- fallbackFlags = { "--std=c11" },
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "asm" },
  },
  asm_lsp = {
    filetypes = {
      "asm",
      "S",
      "vmasm",
    },
    root_markers = {},
  },
  gopls = {},
  rust_analyzer = {
    filetypes = { "rust" },
    -- on_attach = function(client, bufnr)
    --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- end,
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
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
