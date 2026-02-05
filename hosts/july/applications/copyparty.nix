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
      # use lists to set multiple values
      p = [ 3210 ];
      shr = "/shr";
      "shr-adm" = ["lou"];
    };

    accounts = {
      lou = {
        passwordFile = config.age.secrets.copyparty-lou-password.path; 
      };
    };

    volumes = {
    # create a volume at "/" (the webroot), which will
      "/" = {
        # share the contents of "/srv/copyparty"
        path = "/mnt/files";
        # see `copyparty --help-accounts` for available options
        access = {
          A = [ "lou" ];
        };
        # see `copyparty --help-flags` for available options
        flags = {
          # "fk" enables filekeys (necessary for upget permission) (4 chars long)
          fk = 4;
          # scan for new files every 60sec
          scan = 60;
          # volflag "e2d" enables the uploads database
          e2d = true;
          # "d2t" disables multimedia parsers (in case the uploads are malicious)
          d2t = true;
          # skips hashing file contents if path matches *.iso
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