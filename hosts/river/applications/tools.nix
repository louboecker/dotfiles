{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pulsemeeter
    nextcloud-client
    scrcpy
    xdg-utils 
    qpwgraph
    appimage-run
  ] ++ (with pkgs.kdePackages; [
      
  ]);
}