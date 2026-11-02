{ ... }:
{
  imports = [
    ./desktop
    ./development
  ];

  home.username = "lou";
  home.homeDirectory = "/home/lou";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
