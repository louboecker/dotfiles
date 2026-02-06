{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode
    git
    jujutsu
    pnpm
    nodejs_25
  ];
}