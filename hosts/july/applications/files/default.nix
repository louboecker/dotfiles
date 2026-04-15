{ ... }:
{
  users.groups.files = { };

  imports = [
    ./copyparty.nix
    ./syncthing.nix
  ];
}