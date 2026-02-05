{ pkgs, ...}: {
  users.defaultUserShell = pkgs.fish;
  users.users.lou.useDefaultShell = true;
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  services.ringboard.wayland.enable = true;

  environment.systemPackages = with pkgs; [
    pulsemeeter
    nextcloud-client
    scrcpy
    xdg-utils 
    qpwgraph
    appimage-run
    gparted
    woeusb
  ] ++ (with pkgs.kdePackages; [
      isoimagewriter
  ]);

  services.flatpak.enable = true;
}