local cmd = vim.cmd
local api = vim.api
api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.schedule(function()
      cmd('FormatWrite')
    end)
  end,
})
require('formatter').setup({
  logging = false,
  log_level = vim.log.levels.WARN,
  filetype = {
    javascript = {
      require('formatter.filetypes.javascript').eslint_d,
    },
    javascriptreact = {
      require('formatter.filetypes.javascriptreact').eslint_d,
    },
    typescript = {
      require('formatter.filetypes.typescript').eslint_d,
    },
    typescriptreact = {
      require('formatter.filetypes.typescriptreact').eslint_d,
    },
    json = {
      require('formatter.filetypes.json').eslint_d,
    },
    nix = {
      require('formatter.filetypes.nix').nixfmt,
    },
    go = {
      require('formatter.filetypes.go').gopls,
      require('formatter.filetypes.go').golines,
      require('formatter.filetypes.go').gofumpt,
      require('formatter.filetypes.go').goimports
    },
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
})
