{
  description = "system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # hyprland.url = "github:hyprwm/Hyprland";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    # stylix.url = "github:danth/stylix"; # /cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # solaar = {
    #   url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

  };

  outputs =
    { nixpkgs
    , nixos-hardware
    , # home-manager,
      # nixpkgs-unstable,
      # stylix,
      # solaar,
      nixvim
    , nvf
    , # nix-minecraft,
      ...
    } @ inputs:
    # let
    #   inputs.pkgs-unstable = import nixpkgs-unstable {
    #     system = "x86_64-linux";
    #     config.allowUnfree = true;
    #   };
    # in
    {
      nixosConfigurations.alpha-compooper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.framework-16-7040-amd
          # stylix.nixosModules.stylix
          # solaar.nixosModules.default
          nixvim.nixosModules.nixvim
          nvf.nixosModules.default
          # home-manager.nixosModules.home-manager
          # nix-minecraft.nixosModules#.minecraft-servers

        ];
      };
    };
}
