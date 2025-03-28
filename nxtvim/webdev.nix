{ ... }: {
  plugins = {
    ts-autotag.enable = true;
    typescript-tools.enable = true;
    # sandwich = {
    #   enable = true;
    #   settings.no_default_key_mappings = 1;
    # };

    # not webdev but too bad:
    rustaceanvim.enable = true;
  };
}
