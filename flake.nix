{
  description = "Simple rust project";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , ...
    }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      buildInputs = with pkgs; [ ]; # dependencies here
    in
    {
      devShell = with pkgs; mkShell {
        buildInputs = buildInputs ++ [
          rustc
          cargo
          rust-analyzer
          rustfmt
          clippy
        ];
        RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";
        LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
      };
    });
}
