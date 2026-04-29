{ pkgs, inputs, ... }:

{
  programs.nixvim = {
    config = {
      opts = {
        number = true;
        relativenumber = true;
        autoindent = true;
        shiftwidth = 2;
        incsearch = true;
        swapfile = false;
        expandtab = true;

        updatetime = 100; # faster completion
        autowrite = true;
        confirm = true;
        clipboard = "unnamedplus";
        cursorline = true;
        shiftround = true;
        signcolumn = "yes";

        ignorecase = true;
        undofile = true; # Build-in persistent undo
        undolevels = 10000;
      };

      plugins = {
        lualine.enable = true;
        telescope.enable = true;
        web-devicons.enable = true;
        # treesitter.enable = true;
        nvim-tree.enable = true;
        # neocord.enable = true;
        luasnip.enable = true;
        nix.enable = true;
        conform-nvim = {
          # settings = { formatters_by_ft.python = [ "black" ]; };
        };
        neo-tree.enable = true;
        which-key.enable = true;
        otter = {
          package = "inputs.pkgs-unstable.vimPlugins.otter-nvim";
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            kotlin_language_server.enable = true;
            # pyright.enable = true;
            # jdtls.enable = true;
            # ts_ls.enable = true;
            pylsp = {
              enable = true;
              # settings.plugins = {
              # black.enabled = true;
              # flake8.enabled = true;
              # isort.enabled = true;
              # jedi.enabled = true;
              # mccabe.enabled = true;
              # pycodestyle.enabled = true;
              # pydocstyle.enabled = true;
              # pyflakes.enabled = true;
              # pylint.enabled = true;
              # rope.enabled = true;
              # yapf.enabled = true;
              # };
            };
          };
        };

        lspkind.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
        };
      };

      extraPlugins = [ pkgs.vimPlugins.vim-be-good ];

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          enable_sidebar_background = true;
        };
      };

      enable = true;
      enableMan = true;
      defaultEditor = true;
      clipboard.providers.wl-copy.enable = true;
    };
    # none-ls.sources.formatting.black.enable = true;
  };

  environment.systemPackages = [
    pkgs.nodePackages.typescript-language-server
    pkgs.vimPlugins.vim-be-good
  ];
}
