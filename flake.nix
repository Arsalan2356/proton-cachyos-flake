{
  description = "Nix Flake for Proton CachyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      source = builtins.fromJSON (builtins.readFile ./sources.json);
    in {
      packages.${system} = {
        proton-cachyos = pkgs.callPackage ./default.nix {
          inherit source;
        };
        default = self.packages.${system}.proton-cachyos;
      };

      apps.${system} = let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          update = {
            type = "app";
            program = "${pkgs.callPackage ./update-scripts {}}/bin/commit-update.nu";
          };
        };
    };
}
