  { config, pkgs, ... }:
  {

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.

  };
  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    xserver.enable = false; # Disables X11 completely
};

environment.systemPackages = with pkgs;
  [
    kitty
    rofi-wayland
    wl-clipboard
    playerctl
    brightnessctl
    jq
    nwg-displays
    hyprshot
    nautilus
    satty
    yazi
  ];
  }
