{
  activeTheme,
  username,
  ...
}:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  _module.args = { inherit activeTheme; };

  programs.home-manager.enable = true;
}
