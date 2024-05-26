return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- other format
        "prettier",

        -- c/cpp stuff
        "clangd",
        "clang-format",

        -- rust
        "rust-analyzer",
        -- json
        "json-lsp",
        -- xml
        "lemminx",
        -- python
        "pyright",
        -- bash
        "bash-language-server",
        -- cmake
        "cmake-language-server",
        -- sql
        "sqlls",
        -- assermbly
        "asm-lsp",
        -- latex
        "ltex-ls",
        -- typst
        "typst_ls",

        -- front end
        "html-lsp",
        "css-lsp",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "xml",
        "bash",
        "ini",
        "json",
        "toml",
        "cmake",
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup()
    end,
  },
}
