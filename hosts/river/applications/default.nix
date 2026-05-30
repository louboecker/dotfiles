{ lib, ...}: {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowBrokenPredicate = pkg: builtins.elem (lib.getName pkg) [
    "cinny-desktop"
  ];
  
  imports = [
    ./applications.nix
    ./development.nix
    ./gaming.nix
    ./tools.nix

    ./syncthing.nix
  ];
}