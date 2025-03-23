{ ... }: {
  programs.nixvim = {
    enable = true;
    enableMan = true;
    defaultEditor = true;
    clipboard.providers.wl-copy.enable = true;
    imports = [
      ./options.nix
      ./ui.nix
      ./lsp.nix
      ./misc.nix
      ./qol.nix
      ./webdev.nix
      ./keymaps.nix
    ];
  };
}
