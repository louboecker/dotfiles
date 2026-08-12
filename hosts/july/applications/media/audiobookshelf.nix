{ config, ... }: {
  services.audiobookshelf = {
    enable = true;
    port = 8071;
  };

  services.nginx.virtualHosts."audiobooks.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.audiobookshelf.port}";
      proxyWebsockets = true;
    };
  };
}