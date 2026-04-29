{
  activeTheme,
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    home.packages = [ pkgs.fuzzel ];
    home.file.".config/fuzzel/fuzzel.ini" = {
      force = true;
      text = ''
        [main]
        font=CaskaydiaCove Nerd Font Mono:size=12
        scale=1.2
        prompt="❯ "

        [colors]
        background=${builtins.substring 1 6 activeTheme.base00}dd
        text=${builtins.substring 1 6 activeTheme.base04}ff
        prompt=${builtins.substring 1 6 activeTheme.base0B}ff
        placeholder=${builtins.substring 1 6 activeTheme.base0D}ff
        input=${builtins.substring 1 6 activeTheme.base04}ff
        match=${builtins.substring 1 6 activeTheme.base0E}ff
        selection=${builtins.substring 1 6 activeTheme.base0F}ff
        selection-text=${builtins.substring 1 6 activeTheme.base04}ff
        selection-match=${builtins.substring 1 6 activeTheme.base0E}ff
        counter=${builtins.substring 1 6 activeTheme.base03}ff
        border=${builtins.substring 1 6 activeTheme.base0E}ff
      '';
    };
  };
}
