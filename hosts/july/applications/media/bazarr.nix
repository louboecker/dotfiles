{ config, ... }:
{
  services.bazarr = {
    enable = true;
    user = "media";
    group = "media";
  };
  services.nginx.virtualHosts."bazarr.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.bazarr.listenPort}";
      proxyWebsockets = true;
    };
  };
}
