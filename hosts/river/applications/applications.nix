{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium
    discord
    spotify
    thunderbird

    telegram-desktop
    signal-desktop
    # cinny-desktop
  ];
}