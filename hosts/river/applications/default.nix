{ lib, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "discord-ptb"
    "spotify"
    "steam"
    "steam-unwrapped"
    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced"
    "vscode"
    "vscode-with-extensions"
    "vscode-extension-ms-vscode-remote-vscode-remote-extensionpack"
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "idea"
    "ngrok"
  ];

  nixpkgs.config.allowBrokenPredicate = pkg: builtins.elem (lib.getName pkg) [
    "cinny-desktop"
  ];
  
  imports = [
    ./applications.nix
    ./development.nix
    ./gaming.nix
    ./tools.nix
  ];
}