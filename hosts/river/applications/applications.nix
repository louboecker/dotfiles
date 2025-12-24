{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    discord
    spotify
    thunderbird
  ];
}