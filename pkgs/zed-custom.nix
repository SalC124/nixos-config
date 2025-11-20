{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    (inputs.nixpkgs-unstable.zed-editor.overrideAttrs (oldAttrs: {
      pname = "zed-editor-custom"; # Change pname to force new derivation
      # version = "0.209.2-pre";
      version = "0.208.5";

      src = pkgs.fetchFromGitHub {
        owner = "zed-industries";
        repo = "zed";
        tag = "v0.209.2-pre";
        # hash = "sha256-H6egqg5hdN+140WE0hrKm6B5hNGzAjzgYvEpgNwxSPU=";
        hash = "sha256-6B0A6cMCTFGYRrAekTjHo667WcS9aTZbrjaGxKP6QfA=";
      };

      # cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      cargoHash = "sha256-wOhzHMh1nhWTpzzw7phOmhHMV4h7S+e+2SUkK4RK2b8=";

      patches = [ ];
    })).fhs
  ];
}
