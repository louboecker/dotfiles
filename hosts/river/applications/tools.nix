{ pkgs, affinity-nix, ...}: {
  users.defaultUserShell = pkgs.fish;
  users.users.lou.useDefaultShell = true;
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  services.ringboard.wayland.enable = true;

  services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [
    pulsemeeter
    nextcloud-client
    scrcpy
    xdg-utils 
    qpwgraph
    appimage-run
    gparted
    woeusb
    sbctl
    ffmpeg-full
    solaar
    ngrok
    yt-dlp
    net-tools
    mtr
    openrgb
    affinity-nix.packages.x86_64-linux.v3
  ] ++ (with pkgs.kdePackages; [
      isoimagewriter
      gwenview
  ]);

  services.flatpak.enable = true;
}