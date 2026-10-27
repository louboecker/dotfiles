{ hyprland, pkgs, ... }: {
  # services.displayManager.plasma-login-manager.enable = true;
  # services.desktopManager.plasma6.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland"; # Or "hyprland" or "sway"
    configHome = "/home/lou";
  };

  imports = [
    hyprland.nixosModules.default
  ];
  
  programs.hyprland = {
    enable = true;

    plugins = with pkgs; [
      hyprlandPlugins.hyprsplit
    ];

    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  programs.dux-shell = {
    enable = true;

    systemd = {
      enable = true; 
      restartIfChanged = true; 
    };

    plugins = {
      dankKDEConnect.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  systemd.user.targets.graphical-session = {
    wants = [ "xdg-desktop-autostart.target" ];
  };
}
