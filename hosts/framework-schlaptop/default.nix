# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, username, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    inputs.nixpkgs-unstable.zed-editor
    inputs.uncpkgs.microsoft-edge
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager.users.${username} = {
    home.stateVersion = "25.11";
  };
  system.stateVersion = "25.11";
}
