  { config, pkgs, ... }:
  {


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
    wofi
    waybar
    hyprpaper
    wl-clipboard
    grim
    slurp
  ];
  }