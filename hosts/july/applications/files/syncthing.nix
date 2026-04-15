{ config, ... }:
{
  systemd.tmpfiles.rules = [
    "d /var/lib/syncthing 0755 syncthing files"
  ];

  services.syncthing = {
    enable = true;
    group = "files";

    configDir = "/var/lib/syncthing";
    dataDir = "/var/lib/syncthing/";

    openDefaultPorts = true;

    settings = {
      gui.insecureSkipHostcheck = true;
      devices = {
        river.id = "3WFVGHT-SPOM4N7-XAWEBT7-A7KEFI3-V7AAKWL-GFDTR76-6JDHEPH-ELSOXAB";
      };
      folders = {
        obsidian = {
          label = "Obsidian";
          path = "/var/lib/syncthing/obsidian";
          devices = [
            "river"
          ];
        };
      };
    };
  };

  services.nginx.virtualHosts."sync.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://${config.services.syncthing.guiAddress}";
      proxyWebsockets = true;
    };
  };

  services.nginx.tailscaleAuth = {
    enable = true;
    virtualHosts = [ "sync.boecker.dev" ];
  };
}
