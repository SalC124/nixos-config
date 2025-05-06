{ pkgs, ... }:
{
  plugins = {
    nix-develop.enable = true;
    which-key.enable = true;
    undotree.enable = true;
    cursorline.enable = true;
    nvim-autopairs.enable = true;
    todo-comments.enable = true;
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
    numbertoggle.enable = true;
    neo-tree = {
      enable = true;
      enableRefreshOnWrite = true;
      window.position = "right";
      window.width = 24;
    };
    nvim-colorizer.enable = true;
    image = {
      enable = true;
    };
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };
    cmp-spell = {
      enable = true;
    };
  };
}
