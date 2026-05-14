{
  activeTheme,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zsh = {
      enable = true;
    };
    home.file.".config/starship.toml" = {
      force = true;
      text = ''
        palette = "catppuccin_mocha"

        format = ''''
        [\(](bold lavender)$username(bold text)[\)](bold lavender)[-\[](bold lavender)$directory[\]](bold lavender)$git_branch$rust$c$java$haskell$python$nodejs$kotlin$nix_shell
        (bold lavender)$character
        ''''

        right_format = ''''
        $cmd_duration
        ''''

        add_newline = true

        [cmd_duration]
        min_time = 500
        show_milliseconds = true
        show_notifications = false
        min_time_to_notify = 30_000
        format = '[$duration](bold yellow)'

        [nix_shell]
        disabled = false
        impure_msg = "[](bold blue)"
        pure_msg = "[](bold green)"
        unknown_msg = "[](bold yellow)"
        symbol = ""
        format = '[-\[](bold lavender)$state[\]](bold lavender)'

        [fill]
        symbol = '─'
        style = 'bold lavender'

        [git_branch]
        style = "bold sapphire"
        format = '[-\[](bold lavender)[$symbol]($style)[$branch]($style)[\]](bold lavender)'

        [directory]
        truncation_length = 3
        style = "bold mauve"
        truncation_symbol = "…/"
        format = '[$path]($style)[$read_only]($read_only_style)'

        [directory.substitutions]
        "Documents" = "󰈙"
        "Downloads" = ""
        "Music" = "󰝚"
        "Pictures" = ""
        "Developer" = "󰲋"

        [username]
        show_always = true
        style_user = "fg:text"
        style_root = "fg:text"
        format = '[$user]($style)'

        [character]
        disabled = false
        success_symbol = '[❯](bold fg:green)'
        error_symbol = '[❯](bold fg:red)'
        vimcmd_symbol = '[N](bold fg:green)'

        [nodejs]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol( $version)](fg:green)]($style)[\]](bold lavender)'

        [c]
        symbol = ""
        format = '[-\[](bold lavender)[$symbol](fg:blue)[ $version](fg:blue)[\]](bold lavender)'

        [rust]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol rust-tacular!](fg:peach)]($style)[\]](bold lavender)'

        [java]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol( $version)](fg:blue)]($style)[\]](bold lavender)'

        [kotlin]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol( $version)](fg:mauve)]($style)[\]](bold lavender)'

        [haskell]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol( $version)](fg:blue)]($style)[\]](bold lavender)'

        [python]
        symbol = ""
        format = '[-\[](bold lavender)[[$symbol( $version)](fg:yellow)]($style)[\]](bold lavender)'

        [palettes.catppuccin_mocha]
        rosewater = "${activeTheme.base05}"
        flamingo = "${activeTheme.base04}"
        pink = "${activeTheme.base0E}"
        mauve = "${activeTheme.base0E}"
        red = "${activeTheme.base08}"
        maroon = "${activeTheme.base08}"
        peach = "${activeTheme.base09}"
        yellow = "${activeTheme.base0A}"
        green = "${activeTheme.base0B}"
        teal = "${activeTheme.base0C}"
        sky = "${activeTheme.base0D}"
        sapphire = "${activeTheme.base0D}"
        blue = "${activeTheme.base0D}"
        lavender = "${activeTheme.base0E}"
        text = "${activeTheme.base05}"
        subtext1 = "${activeTheme.base04}"
        subtext0 = "${activeTheme.base04}"
        overlay2 = "${activeTheme.base0F}"
        overlay1 = "${activeTheme.base0F}"
        overlay0 = "${activeTheme.base0F}"
        surface2 = "${activeTheme.base03}"
        surface1 = "${activeTheme.base02}"
        surface0 = "${activeTheme.base02}"
        base = "${activeTheme.base00}"
        mantle = "${activeTheme.base01}"
        crust = "${activeTheme.base01}"
      '';
    };
  };
}
