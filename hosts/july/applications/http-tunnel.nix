{ ... }: {
  services.nginx.virtualHosts."tunnel.boecker.dev" = {
    locations."/" = {
      proxyPass = "http://localhost:3303";

      extraConfig = ''
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_redirect off;
      '';
    };
  };
}
