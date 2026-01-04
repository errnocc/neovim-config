require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>sw", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "Switch Source and Header" })
map("i", "jk", "<ESC>")
map("n", "<leader>ej", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Goto next diagnostic" })
map("n", "<leader>ek", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Goto next diagnostic" })

map("n", "<leader>eo", vim.diagnostic.open_float, { desc = "Open current diagnostic" })
map("n", "<leader>es", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
map("n", "<leader>ed", "<cmd>Telescope diagnostics<CR>", { desc = "Open diagnostic list" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local pantran = require "pantran"
local opts = { noremap = true, silent = true, expr = true }
map("n", "<leader>tr", pantran.motion_translate, opts)
map("n", "<leader>trr", function()
  return pantran.motion_translate() .. "_"
end, opts)
map("x", "<leader>tr", pantran.motion_translate, opts)
--setup mapping to call :LazyGit

map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGIT" })

map("n", "<leader>fs", ":Telescope lsp_workspace_symbols<CR>", { desc = "Find symbol" })

local function change_root_to_global_cwd()
  local api = require "nvim-tree.api"
  local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end

map("n", "<leader>tn", change_root_to_global_cwd, vim.tbl_extend("force", opts, { desc = "Change Root To Global CWD" }))

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_format = "fallback", range = range }
end, { range = true })

local neogen = require "neogen"
map("n", "<leader>nf", function()
  neogen.generate()
end, { desc = "Generate annotations" })

local luasnip = require "luasnip"
local cmp = require "cmp"

cmp.setup {

  -- ... Your other configuration ...

  mapping = {

    -- ... Your other mappings ...
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm {
            select = true,
          }
        end
      else
        fallback()
      end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- ... Your other mappings ...
  },

  -- ... Your other configuration ...
}

-- LSP configure
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Lsp all references" })
map("n", "<leader>gd", vim.lsp.buf.type_definition, { desc = "Lsp type definition" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Lsp function implementation" })
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Lsp symbol rename" })

map("n", "<leader>tp", "<cmd>Telescope projects<CR>", { desc = "Telescope projects" })
