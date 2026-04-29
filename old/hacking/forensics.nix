{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    capstone
    ddrescue
    ext4magic
    extundelete
    ghidra-bin
    git
    p0f
    pdf-parser
    python312Packages.binwalk
    python312Packages.distorm3
    sleuthkit
    # volatility
  ];
}
