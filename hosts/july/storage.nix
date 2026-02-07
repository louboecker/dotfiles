{ config, self, pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];

  # fileSystems."/mnt/nextcloud" = {
  #   device = "//u541952-sub2.your-storagebox.de/u541952-sub2";
  #   fsType = "cifs";
  #   options = [ "credentials=${config.age.secrets.nextcloud-samba-credentials.path}" "x-systemd.automount" "noauto" "uid=994" "gid=993" "umask=0770" "nofail" ];
  # };

  # fileSystems."/var/lib/nextcloud" = {
  #   device = "/mnt/nextcloud/nextcloud";
  #   fsType = "none";
  #   options = [ "bind" "uid=994" "gid=993" "umask=0770" ];
  # };

  # age.secrets.nextcloud-samba-credentials.file = "${self}/secrets/samba/nextcloud-samba-credentials.age";

  age.secrets.files-samba-credentials.file = "${self}/secrets/samba/files-samba-credentials.age";

  fileSystems."/mnt/files" = {
    device = "//u541952-sub1.your-storagebox.de/u541952-sub1";
    fsType = "cifs";
    options = [ "credentials=${config.age.secrets.files-samba-credentials.path}" "noauto" "nofail" "uid=971" "gid=966" ];
  };

  age.secrets.media-samba-credentials.file = "${self}/secrets/samba/media-samba-credentials.age";

  fileSystems."/mnt/media" = {
    device = "//u541952-sub3.your-storagebox.de/u541952-sub3";
    fsType = "cifs";
    options = [ "credentials=${config.age.secrets.media-samba-credentials.path}" "noauto" "nofail" "uid=967" "gid=965" "file_mode=0660" "dir_mode=0770" "noserverino" ];
  };
}