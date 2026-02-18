{ config, ... }:
{
  services.memos = {
    enable = true;

    settings = {
      MEMOS_MODE = "prod";
      MEMOS_ADDR = "127.0.0.1";
      MEMOS_PORT = "5230";
      MEMOS_DATA = config.services.memos.dataDir;
      MEMOS_DRIVER = "postgres";
      MEMOS_DSN = "postgres:///memos?host=/run/postgresql/&sslmode=disable";
      MEMOS_INSTANCE_URL = "https://notes.boecker.dev";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "memos"
    ];
    ensureUsers = [
      {
        name = "memos";
      }
    ];
  };


  services.nginx.virtualHosts."notes.boecker.dev".locations."/" = {
    proxyPass = "http://127.0.0.1:5230";
    proxyWebsockets = true;
  };
}