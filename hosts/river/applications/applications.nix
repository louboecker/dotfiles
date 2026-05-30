{ pkgs, affinity-nix, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    spotify
    thunderbird
    jellyfin-desktop
    vlc

    (obs-studio.override {
      cudaSupport = true;
    })

    affinity-nix.packages.x86_64-linux.v3

    libreoffice-qt-fresh
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-us

    obsidian

    mixxx

    telegram-desktop
    signal-desktop
    fluffychat
    cinny-desktop
  ];
}