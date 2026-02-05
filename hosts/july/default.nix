{ ... }:
{
  imports = [
    ./applications
    ./hardware.nix
    ./networking.nix
    ./user.nix
    ./storage.nix
    ./packages.nix

    # ./dn42
  ];
}