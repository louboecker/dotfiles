{ pkgs, ... }:
{
  imports = [
    ./niri
    ./noctalia.nix
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.frappeBlue;
    name = "catppuccin-frappe-blue-cursors";
    size = 24;
    gtk.enable = true;
  };
}
