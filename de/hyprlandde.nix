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
    # Kitty required for Hyprland
    kitty
    nemo
    rofi-wayland
    grim
    slurp
    wl-clipboard
    playerctl
    brightnessctl
    jq
    waybar
    nwg-displays
    nautilus
    hyprshot
    swaynotificationcenter
    satty
  ];
  }