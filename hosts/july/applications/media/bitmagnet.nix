{ pkgs, config, self, ... }:
{
  services.bitmagnet = {
    enable = true;
    user = "media";
    group = "media";
    settings = {
      dht_crawler.scaling_factor = 10;
      classifier.flags.delete_content_types = [
        "xxx"
        "game"
        "software"
        "comic"
      ];
      postgres.name = "bitmagnet";
      postgres.user = "media";
      postgres.host = "/run/postgresql";
    };
  };

  age.secrets.tmdb-api-key = {
    file = "${self}/secrets/media/tmdb-api-key.age";
    owner = "media";
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "bitmagnet"
    ];
    ensureUsers = [
      {
        name = "media";
      }
    ];
  };

  systemd.services.bitmagnet-postgresql-setup = {
    description = "Bitmagnet PostgreSQL setup";
    after = [ "postgresql.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      Group = "postgres";
      ExecStart = [
        "${config.services.postgresql.package}/bin/psql -c 'ALTER DATABASE \"bitmagnet\" OWNER TO \"media\";'"
      ];
    };
  };

  systemd.services.bitmagnet = {
    after = [ "netns@vpn.target" ];
    bindsTo = [ "netns@vpn.target" ];
    serviceConfig = {
      NetworkNamespacePath = "/var/run/netns/vpn";
      BindReadOnlyPaths = "${config.vpn.dns.resolvconf}:/etc/resolv.conf:norbind";
      InaccessiblePaths = "/run/nscd/socket";
      EnvironmentFile = "${config.age.secrets.tmdb-api-key.path}";
    };
  };

  systemd.services.bitmagnet-proxy = {
    after = [ "bitmagnet.service" ];
    requires = [ "bitmagnet.service" ];
    bindsTo = [ "netns@vpn.target" ];
    serviceConfig = {
      Type = "notify";
      NetworkNamespacePath = "/var/run/netns/vpn";
      ExecStart = "${config.systemd.package}/lib/systemd/systemd-socket-proxyd --exit-idle-time=5min 127.0.0.1:3333";
    };
  };

  systemd.sockets.bitmagnet-proxy = {
    listenStreams = [ "3333" ];
    wantedBy = [ "sockets.target" ];
  };

  services.nginx.virtualHosts."bitmagnet.boecker.dev".locations."/" = {
    proxyPass = "http://127.0.0.1:3333";
    proxyWebsockets = true;
  };

  services.nginx.tailscaleAuth = {
    enable = true;
    virtualHosts = [ "bitmagnet.boecker.dev" ];
  };
}
