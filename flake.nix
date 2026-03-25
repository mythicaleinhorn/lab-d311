{
  description = "hello hello world";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.hello-flake.url = "github:sbellem/hello-flake";

  outputs = { self, nixpkgs, flake-utils, hello-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            # specify the default package
            hello-flake.defaultPackage.${system}

            # specify the hello pacakge
            #hello-flake.packages.${system}.hello
          ];
        };
      }
    );
}