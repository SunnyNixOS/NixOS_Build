  { config, pkgs, ... }:
  {

  # Enables the X11 windowing system.
  services.xserver.enable = true;

  # Enables the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  }