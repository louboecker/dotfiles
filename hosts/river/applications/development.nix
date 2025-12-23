{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscodium
    git
    jujutsu
  ];
}