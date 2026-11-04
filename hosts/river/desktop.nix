{ pkgs, ... }: {
  programs.niri.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;

  services.displayManager.dux-greeter = {
    enable = true;
    compositor = {
      name = "niri";
      customConfig = ''
        input {
            keyboard {
                xkb {
                    layout "de"
                }
            }
        }
      '';
    };
    configHome = "/home/lou";
  };

  # system services dux shell relies on; the shell itself is set up in ./home
  services.accounts-daemon.enable = true;
  hardware.i2c.enable = true;
  users.users.lou.extraGroups = [ "i2c" ];
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    builtins.toJSON {
      rules = [
        {
          pattern = {
            feature = "procname";
            matches = "niri";
          };
          profile = "Limit Free Buffer Pool On Wayland Compositors";
        }
      ];
      profiles = [
        {
          name = "Limit Free Buffer Pool On Wayland Compositors";
          settings = [
            {
              key = "GLVidHeapReuseRatio";
              value = 0;
            }
          ];
        }
      ];
    };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  systemd.user.targets.graphical-session = {
    wants = [ "xdg-desktop-autostart.target" ];
    before = [ "xdg-desktop-autostart.target" ];
  };
}
