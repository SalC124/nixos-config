{
  description = "system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    uncpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use url = "github:nix-community/nixvim/nixos-<version>"
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    zed-editor.url = "github:zed-industries/zed";
    # nixos-vfio.url = "github:j-brn/nixos-vfio";
  };

  outputs =
    { nixpkgs
    , nixos-hardware
    , zen-browser
    , # home-manager,
      uncpkgs
    , nixpkgs-unstable
    , # stylix,
      # solaar,
      nixvim
    , # nix-minecraft,
      zed-editor
    # , nixos-vfio
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
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
    in
    {
      nixosConfigurations.alpha-compooper = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inputs = extendedInputs;
        };
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.framework-16-7040-amd
          # stylix.nixosModules.stylix
          # solaar.nixosModules.default
          nixvim.nixosModules.nixvim
          # nixos-vfio.nixosModules.default
          # home-manager.nixosModules.home-manager
          # nix-minecraft.nixosModules#.minecraft-servers
        ];
      };
    };
}
