{ pkgs, ... }:
{
  programs.nixvim.config.plugins = {
    neo-tree = {
      enable = true;
      enableRefreshOnWrite = true;
      window.position = "right";
      window.width = 24;
    };

    lualine.enable = true;

    yazi.enable = true;
    telescope.enable = true;
    web-devicons.enable = true;
    neocord.enable = true;
    # emmet.enable = true;

    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };

    image.enable = true;
    # markview.enable = true;
    render-markdown.enable = true;
    vimtex.enable = true;
    cmp-latex-symbols.enable = true;

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };
    toggleterm = {
      enable = true;
      settings = {
        size = 20;
      };
    };
    multicursors.enable = true;
  };
  environment.systemPackages = [ pkgs.texliveFull pkgs.vimPlugins.bullets-vim ];
}
