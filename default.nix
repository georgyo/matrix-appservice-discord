# This is a minimal `default.nix` by yarn-plugin-nixify. You can customize it
# as needed, it will not be overwritten by the plugin.

{ pkgs ? import <nixpkgs> { } }:

(
  pkgs.callPackage ./yarn-project.nix
    { nodejs = pkgs.nodejs-14_x; }
    { src = pkgs.lib.cleanSourceWith { src = ./.; filter = pkgs.lib.cleanSourceFilter; name = "matrix-appservice-discord"; }; }
).overrideAttrs (oldAttrs: rec {
  pname = "matrix-appservice-discord";
  buildInputs = oldAttrs.buildInputs ++ [ pkgs.python3 ];
  buildPhase = ''
    yarn tsc
  '';

  passthru = {
    nodeAppDir = "libexec/${pname}";
  };
})
