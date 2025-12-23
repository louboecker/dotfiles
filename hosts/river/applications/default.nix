{ lib, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "spotify"
    "steam"
    "steam-unwrapped"
    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced"
  ];
  
  imports = [
    ./applications.nix
    ./development.nix
    ./gaming.nix
    ./tools.nix
  ];
}