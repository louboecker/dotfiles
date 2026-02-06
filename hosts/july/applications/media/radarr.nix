{ config, ... }:
{
  services.radarr = {
    enable = true;
    user = "media";
    group = "media";
    settings = {
      auth = {
        method = "External";
        type = "DisabledForLocalAddresses";
      };
      log = {
        analyticsEnabled = false;
      };
      postgres = {
        host = "/run/postgresql";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "radarr-main"
      "radarr-log"
    ];
    ensureUsers = [
      {
        name = "media";
      }
    ];
  };

  systemd.services.radarr = {
    wants = [
      "postgresql.target"
      "radarr-postgresql-setup.service"
    ];
    after = [
      "postgresql.target"
      "radarr-postgresql-setup.service"
    ];
  };

  systemd.services.radarr-postgresql-setup = {
    description = "Radarr PostgreSQL setup";
    after = [ "postgresql.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      Group = "postgres";
      ExecStart = [
        "${config.services.postgresql.package}/bin/psql -c 'ALTER DATABASE \"radarr-log\" OWNER TO \"media\";'"
        "${config.services.postgresql.package}/bin/psql -c 'ALTER DATABASE \"radarr-main\" OWNER TO \"media\";'"
      ];
    };
  };

  services.nginx.virtualHosts."radarr.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.radarr.settings.server.port}";
      proxyWebsockets = true;
    };
    locations."/api" = {
      # extra entry to bypass oauth2-proxy
      proxyPass = "http://127.0.0.1:${toString config.services.radarr.settings.server.port}";
      proxyWebsockets = true;
      extraConfig = ''
        auth_request off;
      '';
    };
  };
}
