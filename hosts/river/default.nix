{ ... }:
{
  imports = [
    ./hardware.nix
    ./networking.nix
    ./user.nix
    ./applications
    ./patches
  ];
}