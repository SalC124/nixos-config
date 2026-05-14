{
  description = "system flake (now dendritic!)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    uncpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zed-editor.url = "github:zed-industries/zed/5ec84a926ef83865afb92d2a3d1ca3b419572cf9";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      zen-browser,
      uncpkgs,
      nixpkgs-unstable,
      zed-editor,
      ...
    }@inputs:
    let
      # this config expects to be located in ~/nixos-config/
      system = "x86_64-linux";

      extendedInputs = inputs // {
        uncpkgs = import uncpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        nixpkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      mkHost =
        {
          hostname,
          username,
          theme ? "catppuccin-mocha",
          modules,
        }:
        let
          allThemes = import ./data/themes.nix {
            activeTheme = theme;
            inherit username;
          };
          activeTheme = allThemes.themes.${theme};
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inputs = extendedInputs;
            inherit username activeTheme;
          };
          modules = modules ++ [
            ./hosts/${hostname}
            ./hosts/${hostname}/hardware-configuration.nix
            { networking.hostName = hostname; }
            ./modules/nixos/core/default.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs username activeTheme; };
              home-manager.users.${username} = import ./modules/home/default.nix;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      nixosConfigurations = {
        alpha-compooper = mkHost {
          hostname = "alpha-compooper";
          username = "saltcal";
          modules = [
            nixos-hardware.nixosModules.framework-16-7040-amd
            ./modules/nixos/hardware/amd.nix
            ./modules/nixos/core/boot-grub.nix
            ./modules/nixos/desktop/hyprland.nix
            ./modules/nixos/features/starship.nix
            ./modules/nixos/features/zed.nix
            ./modules/nixos/features/extraneous.nix
            ./modules/nixos/services/syncthing.nix
            ./modules/nixos/desktop/gtk.nix
            ./modules/nixos/services/flatpak.nix
          ];
        };

        gamma-compooper = mkHost {
          hostname = "gamma-compooper";
          username = "saltcal";
          modules = [
            ./modules/nixos/core/boot-systemd.nix
            ./modules/nixos/desktop/hyprland.nix
            ./modules/nixos/features/starship.nix
            ./modules/nixos/features/zed.nix
            ./modules/nixos/desktop/gtk.nix
          ];
          theme = "gruvbox-dark";
        };

        framework-schlaptop = mkHost {
          hostname = "framework-schlaptop";
          username = "nate";
          modules = [
            nixos-hardware.nixosModules.framework-16-7040-amd
            ./modules/nixos/hardware/amd.nix
            ./modules/nixos/core/boot-systemd.nix
            ./modules/nixos/desktop/hyprland.nix
            ./modules/nixos/features/starship.nix
            ./modules/nixos/features/zed.nix
            ./modules/nixos/desktop/gtk.nix
          ];
          theme = "gruvbox-dark";
        };
      };
    };
}
