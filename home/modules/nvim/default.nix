{ config, pkgs, unstable-pkgs, ... }: {
  programs.neovim = {
    enable = true;
    #package = unstable-pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = builtins.readFile ./lua/ExtraLuaConfig.lua;
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
        plugin = fidget-nvim;
        type = "lua";
        config = ''
          require('fidget').setup{}
        '';
      }
      {
        plugin = codeium-vim;
        type = "lua";
        config = builtins.readFile ./lua/codeium.lua;
      }
      {
        plugin = autoclose-nvim;
        type = "lua";
        config = builtins.readFile ./lua/autoclose.lua;
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = builtins.readFile ./lua/treesitter.lua;
      }
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile ./lua/colors.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./lua/lualine.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./lua/telescope.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lua/lspconfig.lua;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gitsigns.lua;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./lua/luasnip.lua;
      }
      {
        plugin = nvim-lint;
        type = "lua";
        config = builtins.readFile ./lua/linter.lua;
      }
      {
        plugin = formatter-nvim;
        type = "lua";
        config = builtins.readFile ./lua/formatter.lua;
      }
    ];

    extraPackages = with pkgs; [
      rnix-lsp
      libclang
      clang-tools
      ripgrep
      fd
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
    ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };
}
