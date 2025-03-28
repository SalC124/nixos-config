{ ... }: {
  plugins = {
    web-devicons.enable = true;
    notify = {
      enable = true;
        timeout = 50;
    };
    noice.enable = true;
    transparent.enable = true;
    lualine.enable = true;
  };
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;
      disable_underline = true;
      flavour = "mocha"; # mocha or frappe
      integrations = {
        treesitter = true;
        noice = true;
        notify = true;
        mini = true;
      };
      styles = {
        booleans = [
          "bold"
          "italic"
        ];
        conditionals = [
          "bold"
        ];
        variables = [
          "italic"
        ];
        functions = [
          "bold"
          "italic"
        ];
      };
      term_colors = true;
    };
  };
}
