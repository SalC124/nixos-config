{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    (pkgs.buildFHSEnv {
      name = "zigger";
      targetPkgs = pkgs: (with pkgs; [
        glibc
        openssl
        rustc
        cargo
        rust-analyzer
        gcc
        stdenv.cc.cc.lib
        zlib
        pkg-config
      ]);
      multiPkgs = pkgs: (with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ]);
      extraInstallCommands = ''
        ln -s "${inputs.zed-editor.packages.${pkgs.system}.default}/share" "$out/"
      '';
      runScript = "${inputs.zed-editor.packages.${pkgs.system}.default}/bin/zeditor";
      passthru = {
        executableName = "zeditor";
        inherit (inputs.zed-editor.packages.${pkgs.system}.default) pname version;
      };
      meta = inputs.zed-editor.packages.${pkgs.system}.default.meta // {
        description = ''
          Wrapped variant of zed-editor which launches in a FHS compatible environment.
          Should allow for easy usage of extensions without nix-specific modifications.
        '';
      };
    })
  ];
}
