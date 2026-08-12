{ ... }: {
  services.g3proxy = {
    enable = true;
    settings = {
      server = [
        {
          name = "socks";
          type = "socks_proxy";
          escaper = "default";
          listen = {
            address = "[::]:10086";
            interface = "tailscale0";
          };
        }
      ];
      resolver = [
        {
          name = "default";
          type = "c-ares";
        }
      ];
      escaper = [
        {
          name = "default";
          type = "direct_fixed";
          no_ipv6 = false;
          resolver = "default";
          resolve_strategy = "ipv6_first";
        }
      ];
    };
  };
}
