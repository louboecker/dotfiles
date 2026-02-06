{ self, pkgs, config, ... }:
{
  services.redis = {
    package = pkgs.valkey;
    servers.oauth2-proxy = {
      enable = true;
      user = "oauth2-proxy";
    };
  };

  services.oauth2-proxy = {
    enable = true;

    oidcIssuerUrl = "https://idm.boecker.dev/oauth2/openid/oauth-proxy";
    clientID = "oauth-proxy";

    provider = "oidc";
    keyFile = config.age.secrets.oauth2-proxy.path;

    cookie.domain = ".boecker.dev";
    email.domains = [ "*" ];

    extraConfig = {
      code-challenge-method = "S256";
      whitelist-domain = "*.boecker.dev";
      reverse-proxy = true;
      scope = "openid email profile groups";
      session-store-type = "redis";
      redis-connection-url = "unix:/run/redis-oauth2-proxy/redis.sock";
    };

    nginx = {
      domain = "auth.boecker.dev";
      virtualHosts = {
        "bt.boecker.dev".allowed_groups = [ "pirates@idm.boecker.dev" ];
        "prowlarr.boecker.dev".allowed_groups = [ "pirates@idm.boecker.dev" ];
        "sonarr.boecker.dev".allowed_groups = [ "pirates@idm.boecker.dev" ];
        "radarr.boecker.dev".allowed_groups = [ "pirates@idm.boecker.dev" ];
        "bazarr.boecker.dev".allowed_groups = [ "pirates@idm.boecker.dev" ];
      };
    };
  };

  age.secrets.oauth2-proxy = {
    file = "${self}/secrets/media/oauth2-proxy.age";
    owner = "oauth2-proxy";
  };
}
