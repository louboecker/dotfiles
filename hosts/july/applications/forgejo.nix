# https://git.marie.cologne/marie/dotfiles/src/branch/main/hosts/artemis/applications/forgejo/default.nix
{
  config,
  pkgs,
  ...
}:
{
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    user = "forgejo";
    group = "forgejo";
    database = {
      type = "postgres";
      createDatabase = true;
      user = "forgejo";
      name = "forgejo";
    };
    lfs.enable = true;
    settings = {
      server = {
        PROTOCOL = "http";
        HTTP_PORT = 8085;
        DOMAIN = "git.boecker.dev";
        ROOT_URL = "https://git.boecker.dev";
        OFFLINE_MODE = false;
      };
      other = {
        SHOW_FOOTER_VERSION = true;
      };
      service = {
        ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
        SHOW_REGISTRATION_BUTTON = false;
        ENABLE_BASIC_AUTHENTICATION = false;
      };
      session = {
        COOKIE_SECURE = true;
        PROVIDER = "db";
        SESSION_LIFE_TIME = 1209600;
      };
      cron.ENABLED = true;
      repository = {
        DISABLE_STARS = true;
        "upload.ENABLED" = false;
      };
      oauth2_client = {
        ENABLE_AUTO_REGISTRATION = true;
        REGISTER_EMAIL_CONFIRM = false;
        USERNAME = "nickname";
      };
    };
  };

  services.nginx.virtualHosts."git.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString config.services.forgejo.settings.server.HTTP_PORT}";
      extraConfig = ''
        client_max_body_size 512M;
      '';
    };
  };

  services.nginx.tailscaleAuth = {
    enable = true;
    virtualHosts = [ "git.boecker.dev" ];
  };

  services.openssh.extraConfig = ''
    AcceptEnv GIT_PROTOCOL
  '';
}
