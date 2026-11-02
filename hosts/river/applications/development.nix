{ pkgs, agenix, colmena, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode
    nixfmt
    jdk25
    mitmproxy

    bruno

    android-tools

    jetbrains-toolbox

    wl-clipboard

    opencode
    claude-code
  ] ++ [
    agenix.packages.x86_64-linux.default 
    colmena.packages.x86_64-linux.colmena
  ];

  virtualisation.waydroid.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  users.users.lou.extraGroups = ["adbusers" "docker"];

  programs.direnv.enable = true;
}
