{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-fzf-native-nvim
      nvim-web-devicons
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup({})
          require('telescope').load_extension('fzf')
          vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
          vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
          vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end, { desc = '[/] Fuzzily search in current buffer' })

          vim.keymap.set('n', '<leader>ft', require('telescope.builtin').git_files, { desc = '[F]ind gi[T]' })
          vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind  [F]iles' })
          vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
          vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind [W]ord' })
          vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [G]rep' })
          vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = "require('gitsigns').setup()";
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          lspconfig.rnix.setup {}
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
          vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
              vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
              local opts = { buffer = ev.buf }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
              vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
              vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
              vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, opts)
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
              end, opts)
            end,
          })
        '';
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup({
             highlight = {
              enable = true,
               additional_vim_regex_highlighting = true,
            },
          })
        '';
      }
      {
        plugin = nvim-lint;
        type = "lua";
        config = ''
          require('lint').linters_by_ft = {
            nix = { 'statix' },
          }
          vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function()
              require('lint').try_lint()
            end,
          })
        '';
      }
      {
        plugin = formatter-nvim;
        type = "lua";
        config = ''
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
              nix = {
                require('formatter.filetypes.nix').nixfmt,
              },
              ['*'] = {
                require('formatter.filetypes.any').remove_trailing_whitespace,
              },
            },
          })
        '';
      }
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          local function colorMyThing(color)
          color = color or 'tokyonight-night'
          vim.cmd.colorscheme(color)

          vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermbg = 'none' })
          vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none', ctermbg = 'none' })
          vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'none', ctermbg = 'none' })
          vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', ctermbg = 'none' })
          end

          colorMyThing()
        '';
      }
      nvim-web-devicons
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'auto',
              component_separators = { left = '', right = ''},
              section_separators = { left = '', right = ''},
              disabled_filetypes = {
                statusline = {},
                winbar = {},
              },
              ignore_focus = {},
              always_divide_middle = true,
              globalstatus = false,
              refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
              }
            },
                    sections = {
                      lualine_a = {'mode'},
                      lualine_b = {'branch', 'diff', 'diagnostics'},
                      lualine_c = {'filename'},
                      lualine_x = {'encoding', 'fileformat', 'filetype'},
                      lualine_y = {'progress'},
                      lualine_z = {'location'}
                    },
                    inactive_sections = {
                      lualine_a = {},
                      lualine_b = {},
                      lualine_c = {'filename'},
                      lualine_x = {'location'},
                      lualine_y = {},
                      lualine_z = {}
                    },
                    tabline = {},
                    winbar = {},
                    inactive_winbar = {},
                    extensions = {}
          }
        '';
      }
    ];

    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      vim.opt.relativenumber = true
      vim.opt.numberwidth = 3
      vim.opt.signcolumn = 'yes'
      vim.opt.laststatus = 3

      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      vim.opt.smartindent = true
      vim.opt.smartcase = true
      vim.opt.mouse = 'a'

      vim.opt.wrap = false

      vim.opt.swapfile = false
      vim.opt.backup = false

      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.ignorecase = true

      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 50

      vim.opt.clipboard = 'unnamedplus'
      vim.opt.cmdheight = 2
      vim.opt.completeopt = { 'menuone', 'noselect' }
      vim.opt.conceallevel = 0
      vim.spelllang = 'en_ca'
      vim.opt.fileencoding = 'utf-8'
    '';

    extraPackages = with pkgs; [
      rnix
      ripgrep
      fd
      nodejs
      statix
      nixfmt
      tree-sitter
      gcc
    ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };

}
