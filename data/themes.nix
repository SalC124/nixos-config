{ activeTheme }:

{
  themes = {
    catppuccin-mocha = {
      name = "catppuccin-mocha";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/nixos-wallpaper.png";

      base00 = "#1e1e2e"; # base
      base01 = "#181825"; # mantle
      base02 = "#313244"; # surface0
      base03 = "#45475a"; # surface1
      base04 = "#585b70"; # surface2
      base05 = "#cdd6f4"; # text
      base06 = "#f5e0dc"; # rosewater
      base07 = "#b4befe"; # lavender
      base08 = "#f38ba8"; # red
      base09 = "#fab387"; # peach
      base0A = "#f9e2af"; # yellow
      base0B = "#a6e3a1"; # green
      base0C = "#94e2d5"; # teal
      base0D = "#89b4fa"; # blue
      base0E = "#cba6f7"; # mauve
      base0F = "#f2cdcd"; # flamingo
    };

    cherry-blossom = {
      name = "cherry-blossom";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/cherry.png";

      base00 = "#fff8fb"; # Very light pink-white (background)
      base01 = "#fce8f2"; # Soft pink (status bars)
      base02 = "#f5d5eb"; # Light lavender-pink (selection)
      base03 = "#c8a8d0"; # Medium purple (comments)
      base04 = "#5a6a88"; # Stronger blue-gray (dark foreground) ← MORE CONTRAST
      base05 = "#3a4a60"; # Deep charcoal blue (caret/operators)
      base06 = "#2a3648"; # Darker slate
      base07 = "#1a2530"; # Almost black
      base08 = "#e63875"; # Vibrant rose (variables)
      base09 = "#ff7a45"; # Bright coral (constants)
      base0A = "#DFA6DA"; # Bold purple (classes)
      base0B = "#4db860"; # Vivid grass green (strings)
      base0C = "#38b8e0"; # Bright sky blue (support)
      base0D = "#5878ff"; # Saturated periwinkle (functions)
      base0E = "#DFA6DA"; # Rich violet (keywords)
      base0F = "#d85888"; # Deep rose (deprecated)
    };

    catppuccin-latte = {
      name = "catppuccin-latte";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/cherry.png";

      base00 = "#eff1f5"; # base
      base01 = "#e6e9ef"; # mantle
      base02 = "#ccd0da"; # surface0
      base03 = "#bcc0cc"; # surface1
      base04 = "#acb0be"; # surface2
      base05 = "#4c4f69"; # text
      base06 = "#dc8a78"; # rosewater
      base07 = "#7287fd"; # lavender
      base08 = "#d20f39"; # red
      base09 = "#fe640b"; # peach
      base0A = "#df8e1d"; # yellow
      base0B = "#40a02b"; # green
      base0C = "#179299"; # teal
      base0D = "#1e66f5"; # blue
      base0E = "#8839ef"; # mauve
      base0F = "#dd7878"; # flamingo
    };

    nord = {
      name = "nord";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/nordnix.png";

      base00 = "#2e3440";
      base01 = "#2e3440";
      base02 = "#3b4252";
      base03 = "#434c5e";

      base04 = "#d8dee9";
      base05 = "#eceff4";

      base08 = "#bf616a";
      base0B = "#a3be8c";
      base0A = "#ebcb8b";

      # Nord’s accent is BLUE → map it to base0E
      base0E = "#81a1c1"; # ACCENT (semantic)
      base0D = "#b48ead"; # secondary accent (lavender)

      base0C = "#88c0d0";
      base09 = "#d08770";
      base0F = "#4c566a";
    };

    gruvbox-dark = {
      name = "gruvbox-dark";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/gruvnix.png";

      base00 = "#282828";
      base01 = "#282828";
      base02 = "#3c3836";
      base03 = "#504945";

      base04 = "#ebdbb2";
      base05 = "#fbf1c7";

      base08 = "#cc241d";
      base0B = "#98971a";
      base0A = "#d79921";

      # Gruvbox’s accent is AQUA → map it to base0E
      base0E = "#689d6a"; # ACCENT (semantic)
      base0D = "#458588"; # secondary accent (base0D)

      base0C = "#689d6a";
      base09 = "#d65d0e";
      base0F = "#928374";
    };

    frutiger-aero = {
      name = "frutiger-aero";
      wallpaper = "/home/saltcal/Pictures/Wallpapers/frutiger.jpg";

      base00 = "#e8f4f8";
      base01 = "#d4e9f0";
      base02 = "#c0dde8";
      base03 = "#a8d0e0";

      base04 = "#2c3e50";
      base05 = "#1a252f";

      base08 = "#ff6b6b";
      base0B = "#7ed321";
      base0A = "#ffd93d";

      # Aero’s accent is BRIGHT CYAN → map it to base0E
      base0E = "#00d4ff"; # ACCENT (semantic)
      base0D = "#4a90e2"; # secondary accent

      base0C = "#00d4ff";
      base09 = "#ff9f43";
      base0F = "#95a5a6";
    };
  };

  inherit activeTheme;
}
