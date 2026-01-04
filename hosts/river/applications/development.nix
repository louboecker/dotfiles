{ pkgs, ...}: {
  # programs.fish = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    vscodium
    git
    jujutsu
  ];
}