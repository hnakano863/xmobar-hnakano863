{ pkgs ? import <nixpkgs> {}
, haskellDepends ? []
, compiler
}:

with pkgs;

let
  ghcEnv = compiler.ghcWithPackages (ps: haskellDepends);
in mkShell {

  buildInputs = [
    ghcEnv
    ghcid
    cabal-install
    cabal2nix
  ];

}
