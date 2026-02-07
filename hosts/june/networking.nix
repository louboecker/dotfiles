{ self, config, ...}: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  networking = {
    hostName = "june";

    nftables = {
      enable = true;
    };
    
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];

    firewall.allowedUDPPorts = [
    ];

    interfaces = {
      enp1s0 = {
        useDHCP = false;
        ipv6.addresses = [
          {
            address = "2a01:4f8:1c19:124a::";
            prefixLength = 64;
          }
        ];
        ipv4.addresses = [
          {
            address = "46.224.204.15";
            prefixLength = 22;
          }
        ];
      };
    };
    defaultGateway = {
      address = "172.31.1.1";
      interface = "enp1s0";
    };
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
    nameservers = [
      # Hetzner
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
      "185.12.64.1"
      "185.12.64.2"
      # Cloudflare
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
      "1.1.1.1"
      "1.0.0.1"
      # Google
      "2001:4860:4860::8888"
      "2001:4860:4860::8844"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  age.secrets.tailscale-auth-key = {
    file = "${self}/secrets/tailscale/june/tailscale-auth-key.age";
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.age.secrets.tailscale-auth-key.path;
    extraSetFlags = [
    ];
  };
    
  boot.kernel.sysctl = {
    "net.ipv6.conf.default.accept_ra"  = 0;
    "net.ipv6.conf.default.autoconf"   = 0;
    "net.ipv6.conf.all.accept_ra"      = 0;
    "net.ipv6.conf.all.autoconf"       = 0;
    "net.ipv6.conf.ens3.accept_ra"     = 0;
    "net.ipv6.conf.ens3.autoconf"      = 0;
  };
}
