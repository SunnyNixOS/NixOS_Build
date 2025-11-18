 
 { config, lib, pkgs, ... }:
# This module is imported into configuration.nix main file
{
 
 # Enable Flatpaks
  services.flatpak.enable = true;

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;
  
  
  # Declare flatpaks you want to download here
  services.flatpak.packages = [
    "com.github.iwalton3.jellyfin-media-player"
    "org.vinegarhq.Sober"
    "com.parsecgaming.parsec"
  ];
  
}  
