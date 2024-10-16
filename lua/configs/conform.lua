local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clangd" },
    c = { "clangd" },
    rust = { "rustfmt" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    xml = { "prettier" },
    toml = { "prettier" },
    markdown = { "prettier" },
    bash = { "prettier" },
    cmake = { "prettier" },
    typst = { "typstfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 50,
    lsp_fallback = true,
  },
}

return options
