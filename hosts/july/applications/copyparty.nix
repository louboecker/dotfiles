{ self, pkgs, config, ... }: {
  environment.systemPackages = [ pkgs.copyparty ];

  age.secrets.copyparty-lou-password = {
    file = "${self}/secrets/copyparty/copyparty-lou-password.age";
    owner = "copyparty";
    group = "copyparty";
  };

  services.copyparty = {
    enable = true;

    settings = {
      i = "0.0.0.0";
      p = [ 3210 ];
      shr = "/shr";
      "shr-adm" = ["lou"];
    };

    accounts = {
      lou.passwordFile = config.age.secrets.copyparty-lou-password.path;
    };

    volumes = {
      "/" = {
        path = "/mnt/files";
        access = {
          A = [ "lou" ];
        };
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
          d2t = true;
          nohash = "\.iso$";
        };
      };
    };
  };

  services.nginx.virtualHosts."files.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://localhost:3210";
    };
  };
}