{ ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "saltcal";
      dataDir = "/home/saltcal/Documents";
      configDir = "/home/saltcal/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "beta-compooper" = {
            id = "DE7IZBL-KEWK2SK-2Z7Y66J-GCMVMMA-K6VNK5W-4WKXAVA-WS7ORNF-5OK36QV";
          };
        };
        folders = {
          "Personal Vault" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/home/saltcal/Obsidian/Personal Vault"; # Which folder to add to Syncthing
            devices = [ "beta-compooper" ]; # Which devices to share the folder with
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
