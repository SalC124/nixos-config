{ ... }: {
  plugins = {
    ts-autotag = {
      enable = true;
      settings = {
        aliases = {
          rust = "typescriptreact";
        };
      };
    };
    typescript-tools.enable = true;
    # sandwich = {
    #   enable = true;
    #   settings.no_default_key_mappings = 1;
    # };

    # not webdev but too bad:
    rustaceanvim.enable = true;
  };
  extraConfigLuaPost = ''
    return {
      {
        "neovim/nvim-lspconfig",
        init_options = {
          userLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            rust = "html",
          },
        },
      },
    }
  '';
}
