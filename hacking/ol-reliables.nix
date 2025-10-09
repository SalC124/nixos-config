{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bettercap
    nmap
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
}
