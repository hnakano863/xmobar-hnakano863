{
  description = "A standard dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      inherit (flake-utils.lib) defaultSystems eachSystem;
      remove = e: builtins.filter (x: x != e);
      systems = remove "aarch64-darwin" defaultSystems;
    in
      eachSystem systems (system:
        let pkgs = nixpkgs.legacyPackages."${system}"; in
        {
          devShell = import ./shell.nix { inherit pkgs; };
        }
      );
}
