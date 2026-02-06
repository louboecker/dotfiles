{ config, ... }:
{
  services.sonarr = {
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
      "sonarr-main"
      "sonarr-log"
    ];
    ensureUsers = [
      {
        name = "media";
      }
    ];
  };

  systemd.services.sonarr = {
    wants = [
      "postgresql.target"
      "sonarr-postgresql-setup.service"
    ];
    after = [
      "postgresql.target"
      "sonarr-postgresql-setup.service"
    ];
  };

  systemd.services.sonarr-postgresql-setup = {
    description = "Sonarr PostgreSQL setup";
    after = [ "postgresql.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      Group = "postgres";
      ExecStart = [
        "${config.services.postgresql.package}/bin/psql -c 'ALTER DATABASE \"sonarr-log\" OWNER TO \"media\";'"
        "${config.services.postgresql.package}/bin/psql -c 'ALTER DATABASE \"sonarr-main\" OWNER TO \"media\";'"
      ];
    };
  };

  services.nginx.virtualHosts."sonarr.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.sonarr.settings.server.port}";
      proxyWebsockets = true;
    };
    locations."/api" = {
      # extra entry to bypass oauth2-proxy
      proxyPass = "http://127.0.0.1:${toString config.services.sonarr.settings.server.port}";
      proxyWebsockets = true;
      extraConfig = ''
        auth_request off;
      '';
    };
  };
}
