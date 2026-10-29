{ config, ... }: {
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://ntfy.boecker.dev";
    };
  };

  services.nginx.virtualHosts."ntfy.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://${config.services.ntfy-sh.settings.listen-http}";
      proxyWebsockets = true;
    };
  };

  services.nginx.tailscaleAuth = {
    enable = true;
    virtualHosts = [ "ntfy.boecker.dev" ];
  };
}
