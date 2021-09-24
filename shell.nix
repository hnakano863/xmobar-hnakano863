{ pkgs ? import <nixpkgs> {} }:
with pkgs;

mkShell {

  buildInputs = [
    ghc
    ghcid
    cabal-install
  ];

}
