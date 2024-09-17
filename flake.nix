{
  description = "Nix flake for ATS2.";

  # nixos-24.05 as of 2024-09-17
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/8f7492cce28977fbf8bd12c72af08b1f6c7c3e49";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          ats2 = pkgs.ats2;
          # TODO: build by ourselves for more granular control
          # ats2 = pkgs.callPackage ./package.nix {};
          default = ats2;
        };
        apps = rec {
          patsopt = flake-utils.lib.mkApp { 
            drv = self.packages.${system}.ats2;
            name = "patsopt";
          };
          default = patsopt;
        };
      }
    );
}
