{ ... }: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ./user.nix
    ./storage.nix
    ./applications
  ];
}