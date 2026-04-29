{ pkgs, ... }: {
  plugins = {
    lspkind.enable = true; # Icons for CMP

    cmp-nvim-lsp-signature-help.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        # LSP
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_signature_help"; }

        # Filesystem paths
        { name = "path"; }

        # Buffer CMP
        { name = "buffer"; }

        # Snippets
        #{ name = "snippy"; }
        { name = "luasnip"; }

        { name = "cmp-dap"; }
      ];
      settings.mapping = {
        "<C-j>" = "cmp.mapping.select_next_item()";

        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-CR>" = "cmp.mapping.confirm({ select = true })";

        "<Tab-CR>" = "cmp.mapping.confirm({ select = true })";

        # "<C-Tab>" = "cmp.mapping.select_next_item()";
        # "<C-Space>" = "cmp.mapping.complete()";
        # "<C-Esc>" = "cmp.mapping.close()";
        # "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
      };
    };

    # LSP's used: css html nix bash java lua csharp
    # Completion path buffer snippy luasnip cmp-dap
    lsp-format.enable = true;
    none-ls = {
      enable = true;
      enableLspFormat = true;
      sources.formatting = {
        nixpkgs_fmt.enable = true;
        prettierd.enable = true;
        black.enable = true;
        google_java_format.enable = true;
        ktlint.enable = true;
        # jq.enable = true;
      };
    };
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true; # LS for Nix
        cssls.enable = true;
        html.enable = true;
        bashls.enable = true;
        pyright.enable = true;
        kotlin_language_server.enable = true;
        jsonls.enable = true;
        # haskell-language-server.enable = true; WHAT THE FRICK
      };
    };

    noice.settings.presets."inc_rename" = true;
    inc-rename.enable = true; # Nice renaming UI
  };

  # Ability to toggle cmp
  extraConfigLua = ''
    -- local format_enabled = false
        vim.cmd("FormatDisable")
        vim.api.nvim_create_user_command(
            "ToggleFormatNotified",
            function()
                if format_enabled then
                    vim.cmd("FormatDisable")
                    require("notify")("Disabled formatting")
                    format_enabled = false
                else
                    vim.cmd("FormatEnable")
                    require("notify")("Enabled formatting")
                    format_enabled = true
                end
            end,
            {}
          )
          vim.api.nvim_create_user_command(
              "FormatOnce",
              function()
                  vim.cmd("FormatEnable")
                  vim.cmd("Format")
                  vim.cmd("FormatDisable")
              end,
              {}
            )


      --   vim.diagnostic.config(
      --       {
      --           virtual_text = false,
      --           float = {border = "rounded"}
      --       }
      --   )
      --
      --   vim.o.updatetime = 250
      --   vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
      --   vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335 guifg=#abb2bf]])
      --
      -- '';
  keymaps = [
    #     {
    #       key = "<leader>fm";
    #       action = "<cmd> Format <CR>";
    #       mode = "n";
    #       options = {
    #         silent = true;
    #         desc = "Format Files";
    #       };
    #     }
    #     {
    #       key = "<leader>fe";
    #       action = "<cmd> FormatEnable <CR>";
    #       mode = "n";
    #       options = {
    #         silent = true;
    #         desc = "Format Files";
    #       };
    #     }
    #     {
    #       key = "<leader>fd";
    #       action = "<cmd> FormatDisable <CR>";
    #       mode = "n";
    #       options = {
    #         silent = true;
    #         desc = "Format Files";
    #       };
    #     }
    #     {
    #       key = "<leader>tf";
    #       action = "<cmd> ToggleFormatNotified <CR>";
    #       mode = "n";
    #       options = {
    #         desc = "Format Toggle";
    #         silent = true;
    #       };
    #     }
    # 
    #     {
    #       key = "<Leader>ra";
    #       action = "<cmd> IncRename <CR>";
    #       mode = "n";
    #       options.desc = "LSP Rename";
    #     }
  ];
}
