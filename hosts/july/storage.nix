{ config, self, pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/mnt/nextcloud" = {
    device = "//u541952-sub2.your-storagebox.de/u541952-sub2";
    fsType = "cifs";
    options = [ "credentials=${config.age.secrets.nextcloud-samba-credentials.path}" "x-systemd.automount" "noauto" "uid=994" "gid=993" "umask=0770" "nofail" ];
  };

  fileSystems."/var/lib/nextcloud" = {
    device = "/mnt/nextcloud/nextcloud";
    fsType = "none";
    options = [ "bind" "uid=994" "gid=993" "umask=0770" ];
  };

  age.secrets.nextcloud-samba-credentials.file = "${self}/secrets/samba/nextcloud-samba-credentials.age";
}