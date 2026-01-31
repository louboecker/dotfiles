{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    (discord.override {
      withVencord = true;
    })
    (discord-ptb.override {
      withVencord = true;
    })
    vesktop
    spotify
    thunderbird

    telegram-desktop
    signal-desktop
    fluffychat
  ];
}