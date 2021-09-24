{ pkgs ? import <nixpkgs> {}, compilerVersion ? "ghc8104" }:
with pkgs;
let
  compiler = haskell.packages."${compilerVersion}".ghcWithPackages (ps: with ps; [
    xmobar
    xmonad-contrib
  ]);
in mkShell {

  buildInputs = [
    compiler
    ghcid
    cabal-install
    cabal2nix
  ];

}
