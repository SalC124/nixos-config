{ lib, config, pkgs, inputs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "saltcal";
      dataDir =   "/home/saltcal/Documents";
      configDir = "/home/saltcal/.config/syncthing";
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "Sal's S24+" = { id = "YNZPFTD-DDWX7RL-JHK33ET-SSRK3PI-MCH5TNQ-NU32TCJ-XBIQ7YS-YGLTEQE"; };
        };
        folders = {
          "Personal Vault" = {         # Name of folder in Syncthing, also the folder ID
            path = "/home/saltcal/Obsidian/Personal Vault";    # Which folder to add to Syncthing
            devices = [ "Sal's S24+" ];      # Which devices to share the folder with
            versioning = {
              type = "simple";
              params.keep = "5";
            };
          };
        };
      };
    };
  };
}