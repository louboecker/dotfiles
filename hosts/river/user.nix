{ pkgs, dux-shell, dms-plugin-registry, ...}: {
  users.users.lou = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPKX4xLlDZtOytnnX8SKVcbHIK0P6E6WPXPVGdE3uMo" # termux
    ];
    useDefaultShell = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit dux-shell dms-plugin-registry; };
    users.lou = import ./home;
  };
}
