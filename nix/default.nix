let
  pkgs    = import <nixpkgs> {};
  version = builtins.readFile ./VERSION;
in rec {
  tarball = pkgs.callPackage ./nix/tarball.nix { inherit version; };
  build   = pkgs.callPackage ./nix/build.nix { inherit tarball version; };
}
