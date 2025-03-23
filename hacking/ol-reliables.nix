{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bettercap
    nmap

  ];
}
