{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    (discord.override {
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

    libreoffice
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-us

    telegram-desktop
    signal-desktop
    fluffychat
  ];
}