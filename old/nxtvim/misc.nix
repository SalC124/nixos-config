{ ... }:
{
  plugins = {
    # mini.enable = true;
    # mini.modules.icons.enable = true;
    # mini.mockDevIcons = true;
    neocord.enable = true;

    obsidian = {
      enable = true;
      settings = {
        completion = {
          min_chars = 1;
          nvim_cmp = true;
        };
        new_notes_location = "current_dir";
        workspaces = [
          {
            name = "home";
            path = "~/";
          }
        ];
        ui = {
          enable = true;
          checkboxes = {
            " " = { char = "󰄱"; hl_group = "ObsidianTodo"; };
            "x" = { char = ""; hl_group = "ObsidianDone"; };
            ">" = { char = ""; hl_group = "ObsidianRightArow"; };
            "~" = { char = "󰰱"; hl_group = "ObsidianTilde"; };
            "!" = { char = ""; hl_group = "ObsidianImportant"; };
          };
        };
      };
    };
  };
}
