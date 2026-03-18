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

    (obs-studio.override {
      cudaSupport = true;
    })

    telegram-desktop
    signal-desktop
    fluffychat
  ];
}