{ mkDerivation, base, lib, xmobar }:
mkDerivation {
  pname = "xmobar-hnakano863";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base xmobar ];
  description = "My xmobar configuration written as a Haskell code";
  license = lib.licenses.mit;
}
