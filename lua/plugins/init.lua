return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
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
  -- {
  --   "nvimdev/lspsaga.nvim",
  --   event = "LspAttach",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter", -- optional
  --     "nvim-tree/nvim-web-devicons", -- optional
  --   },
  -- },
  -- {
  --   "p00f/clangd_extensions.nvim",
  --   lazy = true,
  --   ft = { "cpp", "c", "h", "hpp" },
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     require "configs.extension"
  --   end,
  -- },
  --
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup()
    end,
  },
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup {
        -- IM will be set to `default_im_select` in `normal` mode
        -- For Windows/WSL, default: "1033", aka: English US Keyboard
        -- For macOS, default: "com.apple.keylayout.ABC", aka: US
        -- For Linux, default:
        --               "keyboard-us" for Fcitx5
        --               "1" for Fcitx
        --               "xkb:us::eng" for ibus
        -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
        default_im_select = "keyboard-us",

        -- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
        -- '/usr/local/bin/im-select' for binary without extra arguments,
        -- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "im-select"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        default_command = "fcitx5-remote",

        -- Restore the default input method state when the following events are triggered
        set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

        -- Restore the previous used input method state when the following events
        -- are triggered, if you don't want to restore previous used im in Insert mode,
        -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
        -- as `set_previous_events = {}`
        set_previous_events = { "InsertEnter" },

        -- Show notification about how to install executable binary when binary missed
        keep_quiet_on_no_binary = false,

        -- Async run `default_command` to switch IM or not
        async_switch_im = true,
      }
    end,
    event = "InsertEnter",
    lazy = true,
  },
  {
    "potamides/pantran.nvim",
    config = function()
      require("pantran").setup {
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "google",
        -- Configuration for individual engines goes here.
        engines = {
          google = {
            fallback = {
              default_source = "auto",
              default_target = "zh-CN",
            },
          },
        },
        controls = {
          mappings = {
            edit = {
              n = {
                -- Use this table to add additional mappings for the normal mode in
                -- the translation window. Either strings or function references are
                -- supported.
                ["j"] = "gj",
                ["k"] = "gk",
              },
              i = {
                -- Similar table but for insert mode. Using 'false' disables
                -- existing keybindings.
                ["<C-y>"] = false,
                ["<C-a>"] = require("pantran.ui.actions").yank_close_translation,
              },
            },
            -- Keybindings here are used in the selection window.
            select = {
              n = {
                -- ...
              },
            },
          },
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = { "clangd" },

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = "global",

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath "data",
      }
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  -- {
  --   "frankroeder/parrot.nvim",
  --   dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("parrot").setup {
  --       -- Providers must be explicitly added to make them available.
  --       providers = {
  --         anthropic = {
  --           api_key = os.getenv "ANTHROPIC_API_KEY",
  --         },
  --         gemini = {
  --           api_key = os.getenv "GEMINI_API_KEY",
  --         },
  --         groq =
  --           api_key = os.getenv "GROQ_API_KEY",
  --         },
  --         mistral = {
  --           api_key = os.getenv "MISTRAL_API_KEY",
  --         },
  --         pplx = {
  --           api_key = os.getenv "PERPLEXITY_API_KEY",
  --         },
  --         -- provide an empty list to make provider available (no API key required)
  --         ollama = {},
  --         openai = {
  --           api_key = os.getenv "OPENAI_API_KEY",
  --         },
  --         github = {
  --           api_key = os.getenv "GITHUB_TOKEN",
  --         },
  --         nvidia = {
  --           api_key = os.getenv "NVIDIA_API_KEY",
  --         },
  --         xai = {
  --           api_key = os.getenv "XAI_API_KEY",
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "zapling/mason-conform.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "stevearc/conform.nvim",
  --   },
  -- },
}
