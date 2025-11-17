{ config, lib, pkgs, ... }:
# This module is imported into configuration.nix main file
let
  myUser = "jaime";
  myHome = "/home/${myUser}";
in {
  # Configure File Systems for 2tb drive on main gaming PC
  fileSystems."${myHome}/Documents/2tb_drive" = {
    device = "/dev/disk/by-uuid/2b48454f-c7db-4ace-97df-a24f30038aaf";
    fsType = "ext4";
    options = [
       "defaults"
       "nofail"
    ];
  };

  # Optional: ensure mount point exists if parent directories might not exist
  systemd.tmpfiles.rules = [
    "d ${myHome}/Documents/2tb_drive 0755 ${myUser} ${myUser} -"
  ];
}
