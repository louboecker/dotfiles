{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pulsemeeter
    nextcloud-client
    scrcpy
    xdg-utils 
    qpwgraph
  ] ++ (with pkgs.kdePackages; [
      
  ]);
}