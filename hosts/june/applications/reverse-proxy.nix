{ self, lib, config, ... }: {
  options.services.nginx.virtualHosts = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      config.forceSSL = lib.mkDefault true;
      config.http2 = lib.mkDefault true;
      config.useACMEHost = lib.mkDefault "boecker.dev";
    });
  };

  config = {
    services.nginx = {
      enable = true;
      virtualHosts."_" = {
        default = true;
        locations."/" = {
          return = "404";
        };
      };
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedBrotliSettings = true;
      recommendedProxySettings = true;
    };

    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "emma@boecker.dev";
        dnsProvider = "cloudflare";
        dnsPropagationCheck = true;
        credentialsFile = config.age.secrets.cloudflare-api-key.path;
        # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      };
      certs."boecker.dev" = {
        domain = "*.boecker.dev";
        extraDomainNames = [
          "boecker.dev"
        ];
      };
    };

    users.users.nginx = {
      isSystemUser = true;
      group = "nginx";
      extraGroups = [ "acme" ];
    };
    users.groups.nginx = {};
    age.secrets.cloudflare-api-key.file = "${self}/secrets/cloudflare-api-key.age";
  };
}
