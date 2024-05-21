{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      systems = lib.platforms.unix;
      forAllSystems = lib.genAttrs systems;
    in {
      overlays.default = final: prev: {
        qed = final.callPackage ./default.nix {};
      };

      packages = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in {
          default = pkgs.qed;
          qed = pkgs.qed;
          stylua = pkgs.runCommand "stylua" {
            src = ./.;
            buildInputs = [ pkgs.stylua ];
          } ''
          cd $src
          stylua --check lua/
          touch $out
          '';
        }
      );

      devShell = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          packages = [
            pkgs.sumneko-lua-language-server
            pkgs.stylua
          ];
        }
      );
    };
}
