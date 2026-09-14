{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.unityhub.override {
      extraPkgs = fhsPkgs: [
        fhsPkgs.harfbuzz
        fhsPkgs.libogg
      ];
    })
  ];
}
