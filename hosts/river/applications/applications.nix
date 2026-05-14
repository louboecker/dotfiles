{ pkgs, affinity-nix, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    (discord.override {
      withVencord = true;
    })
    (discord-canary.override {
      withVencord = true;
    })
    legcord
    vesktop
    spotify
    thunderbird
    jellyfin-desktop
    vlc

    (obs-studio.override {
      cudaSupport = true;
    })

    affinity-nix.packages.x86_64-linux.v3

    libreoffice
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