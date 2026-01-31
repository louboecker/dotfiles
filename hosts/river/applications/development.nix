{ pkgs, ...}: {
  # programs.fish = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    vscodium
    vscode
    git
    jujutsu
    pnpm
    nodejs_25
    jetbrains.idea
  ];
}