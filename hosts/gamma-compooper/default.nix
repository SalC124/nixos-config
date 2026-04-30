# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ username, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "192.168.1.54";
      system = "x86_64-linux";
      maxJobs = 2;
      speedFactor = 2;
      supportedFeatures = [
        "nix-command"
        "flakes"
        "big-parallel"
      ];
    }
  ];

  home-manager.users.${username} = {
    home.stateVersion = "25.11";
  };
  system.stateVersion = "25.05";
}
