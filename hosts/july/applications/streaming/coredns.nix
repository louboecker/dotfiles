{ ... }: {
  networking.firewall.allowedTCPPorts = [
    53
  ];

  networking.firewall.allowedUDPPorts = [
    53
  ];

  services.coredns = {
    enable = true;
    config = ''
      . {
        forward . /etc/resolv.conf
        bind ens3

        rewrite continue {
          name exact euc10.contribute.live-video.net stream.boecker.dev
        }
        rewrite continue {
          name regex live(.*).twitch.tv stream.boecker.dev answer auto
        }
        rewrite continue {
          name regex (.*).contribute.live-video.net stream.boecker.dev answer auto
        }
        rewrite continue {
          name regex (.*).global-contribute.live-video.net stream.boecker.dev answer auto
        }
        
        log . {
          class all
        }
      }
    '';
  };
}