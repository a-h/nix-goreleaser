{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system}; 
        goreleaser = pkgs.callPackage ./goreleaser.nix {};
      in
      {
        defaultPackage = goreleaser;
        packages = { 
          goreleaser = goreleaser;
        };
        devShells = {
          default = pkgs.mkShell {
            packages = [ goreleaser ];
          };
          goreleaser = pkgs.mkShell {
            packages = [ goreleaser ];
          };
        };
      }
    );
}
