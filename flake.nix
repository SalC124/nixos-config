{
  description = "system flake (now dendritic!)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    uncpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use url = "github:nix-community/nixvim/nixos-<version>"
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    zed-editor.url = "github:zed-industries/zed/fe26ab68094bc731e0d51a8ad94cb00ad6513b5b";
    # nixos-vfio.url = "github:j-brn/nixos-vfio";
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
      # home-manager,
      uncpkgs,
      nixpkgs-unstable,
      # stylix,
      # solaar,
      nixvim,
      # , nix-minecraft
      zed-editor,
      # , nixos-vfio
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "saltcal";
      theme = "catppuccin-mocha";

      # Create an extended inputs with the imported uncpkgs
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
      allThemes = import ./themes.nix { activeTheme = theme; };
      activeTheme = allThemes.themes.${theme};
      mkHost =
        hostName: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inputs = extendedInputs;
            inherit username activeTheme;
          };
          modules =
            modules
            ++ [
              ./hosts/${hostName}
              ./hosts/${hostName}/hardware-configuration.nix
              { networking.hostName = hostName; }
              ./modules/nixos/core/default.nix
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit inputs username activeTheme; };
                home-manager.users.${username} = import ./modules/home/default.nix;
                home-manager.backupFileExtension = "backup";
              }
            ]
            ++ (if hostName == "gamma-compooper" then [ ./modules/nixos/services/remote-builder.nix ] else [ ]);
        };
    in
    {
      nixosConfigurations = {
        alpha-compooper = mkHost "alpha-compooper" [
          nixos-hardware.nixosModules.framework-16-7040-amd
          ./modules/nixos/hardware/amd.nix
          ./modules/nixos/core/boot-grub.nix
          # stylix.nixosModules.stylix
          # solaar.nixosModules.default
          # nixvim.nixosModules.nixvim
          # nixos-vfio.nixosModules.default
          # home-manager.nixosModules.home-manager
          # nix-minecraft.nixosModules#.minecraft-servers
          ./modules/nixos/desktop/hyprland.nix
          ./modules/nixos/features/starship.nix
          ./modules/nixos/features/extraneous.nix
          ./modules/nixos/services/syncthing.nix
        ];
        gamma-compooper = mkHost "gamma-compooper" [
          ./modules/nixos/core/boot-systemd.nix
          ./modules/nixos/desktop/niri.nix
          ./modules/nixos/features/starship.nix
          ./modules/nixos/features/kitty.nix
          ./modules/nixos/features/fuzzel.nix
        ];
      };
    };
}
