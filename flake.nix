{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs {
          system = system;
        };
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
