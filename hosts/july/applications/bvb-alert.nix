{
  self,
  config,
  bvb-alert,
  pkgs,
  ...
}:
{
  systemd.services.bvb-alert = {
    description = "BVB Alert";
    wantedBy = [ "multi-user.target" ];
    # environment = {
    # };
    serviceConfig = {
      ExecStart = "${bvb-alert.packages.${pkgs.system}.default}/bin/bvb-alert";
      Restart = "on-failure";
      CapabilityBoundingSet = [ "" ];
      LockPersonality = true;
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateTmp = true;
      PrivateUsers = true;
      ProcSubset = "pid";
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectSystem = "strict";
      ReadWritePaths = [];
      RemoveIPC = true;
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [ "@system-service" "~@resources" "~@privileged" ];
      DynamicUser = "yes";
    };
  };
}
