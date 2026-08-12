{ ... }: {
  security.sudo.wheelNeedsPassword = false;

  users.users.lou = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIh+tAKie4OOkzxIwprEcQHiaL4ifkJKcSeN3bytV1rZ"
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPKX4xLlDZtOytnnX8SKVcbHIK0P6E6WPXPVGdE3uMo" 
    ];
  };
}