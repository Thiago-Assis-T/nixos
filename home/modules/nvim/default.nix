{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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

      vim.keymap.set('n', '<leader>tt', vim.cmd.tabnew,{silent = true} )
      vim.keymap.set('n', '<leader>tn', vim.cmd.tabNext,{silent = true} )
      vim.keymap.set('n', '<leader>tp', vim.cmd.tabprevious,{silent = true} )
      vim.keymap.set('n', '<leader>tx', vim.cmd.tabclose,{silent = true} )


    '';
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-fzf-native-nvim
      fuzzy-nvim
      nvim-web-devicons
      cmp-nvim-lsp
      cmp_luasnip
      cmp-fuzzy-path
      cmp-fuzzy-buffer
      {
        plugin = codeium-vim;
        type = "lua";
        config = ''
          vim.keymap.set('i', '<M-cr>', function () return vim.fn['codeium#Accept']() end, { expr = true })
          vim.keymap.set('i', '<M-=>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
          vim.keymap.set('i', '<M-->', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
          vim.keymap.set('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        '';
      }
      {
        plugin = autoclose-nvim;
        type = "lua";
        config = ''
          require("autoclose").setup({
            keys = {
              ["<"] = { escape = false, close = true, pair = "<>" },
            }
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
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'palenight',
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
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
          local lspconfig = require('lspconfig')
          local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
              if desc then
                desc = 'LSP: ' .. desc
              end
              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

          end
          lspconfig.gopls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
          lspconfig.rnix.setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
          local function organize_imports()
            local params = {
              command = "_typescript.organizeImports",
              arguments = {vim.api.nvim_buf_get_name(0)},
            }
            vim.lsp.buf.execute_command(params)
          end
          lspconfig.tsserver.setup{
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
              preferences = {
                disableSuggestions = true,
              }
            },
            commands = {
              OrganizeImports = {
                organize_imports,
                description = "Organize Imports",
              }
            }
          }
        '';
      }
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
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')

          local kind_icons = {
            Text = '󰈚',
            Method = '',
            Function = '󰊕',
            Constructor = '󱌣',
            Field = '󰽐',
            Variable = '',
            Class = '',
            Interface = '',
            Module = '󰕳',
            Property = '',
            Unit = '󱍓',
            Value = '󰎠',
            Enum = '',
            Keyword = '',
            Snippet = '',
            Color = '',
            File = '󰈙',
            Reference = '',
            Folder = '',
            EnumMember = '',
            Constant = '',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = '󰉺',
          }

          cmp.setup({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'fuzzy_path'},
              { name = 'fuzzy_buffer', keyword_length = 5 },
            }),
            formatting = {
              fields = { 'kind', 'abbr', 'menu' },
              format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                vim_item.menu = ({
                  nvim_lsp = '[LSP]',
                  luasnip = '[Snippet]',
                  buffer = '[Buffer]',
                  path = '[Path]',
                })[entry.source.name]
                return vim_item
              end,
            },
          })
        '';
      }
      {
        plugin = luasnip;
        type = "lua";
        config = ''
          require("luasnip.loaders.from_vscode").lazy_load()
          vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
          vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
          vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
          vim.keymap.set({"i", "s"}, "<C-E>", function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
          end, {silent = true})
        '';

      }
      {
        plugin = nvim-lint;
        type = "lua";
        config = builtins.readFile ./lua/linter.lua "";
      }
      {
        plugin = formatter-nvim;
        type = "lua";
        config = builtins.readFile ./lua/formatter.lua;
      }
    ];

    extraPackages = with pkgs; [
      rnix-lsp
      ripgrep
      fd
      nodejs
      statix
      nixfmt
      codeium
      tree-sitter
      gcc
      gopls
      gofumpt
      gotools
      golines
      golangci-lint
      nodePackages.typescript-language-server
      nodePackages.eslint
      nodePackages.eslint_d
    ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };
}
