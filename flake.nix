{
  description = "A standard dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      inherit (flake-utils.lib) defaultSystems eachSystem;
      inherit (builtins) elem filter;
      systems = filter (x: !elem x ["aarch64-darwin" "x86_64-darwin"]) defaultSystems;
    in
      eachSystem systems (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
          compilerVersion = "ghc8104";
          compiler = pkgs.haskell.packages."${compilerVersion}";
          drv = compiler.callPackage ./default.nix { };
        in
        {
          defaultPackage = drv;

          devShell = import ./shell.nix {
            inherit pkgs compiler;
            haskellDepends = drv.getCabalDeps.executableHaskellDepends;
          };
        }
      );
}
