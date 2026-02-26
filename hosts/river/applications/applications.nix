{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    (discord.override {
      withVencord = true;
    })
    vesktop
    spotify
    thunderbird
    jellyfin-desktop
    vlc

    obs-studio

    telegram-desktop
    signal-desktop
    fluffychat
  ];
}