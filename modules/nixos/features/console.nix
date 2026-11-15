{
  pkgs,
  activeTheme,
  ...
}:

{
  console = {
    enable = true;

    font = "ter-v24n";
    packages = [ pkgs.terminus_font ];

    colors = [
      (builtins.substring 1 6 activeTheme.base00)
      (builtins.substring 1 6 activeTheme.base08)
      (builtins.substring 1 6 activeTheme.base0B)
      (builtins.substring 1 6 activeTheme.base0A)
      (builtins.substring 1 6 activeTheme.base0D)
      (builtins.substring 1 6 activeTheme.base0E)
      (builtins.substring 1 6 activeTheme.base0C)
      (builtins.substring 1 6 activeTheme.base05)
      (builtins.substring 1 6 activeTheme.base03)
      (builtins.substring 1 6 activeTheme.base09)
      (builtins.substring 1 6 activeTheme.base01)
      (builtins.substring 1 6 activeTheme.base02)
      (builtins.substring 1 6 activeTheme.base04)
      (builtins.substring 1 6 activeTheme.base06)
      (builtins.substring 1 6 activeTheme.base0F)
      (builtins.substring 1 6 activeTheme.base07)
    ];
  };
}
