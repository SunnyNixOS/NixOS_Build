  { config, pkgs, lib, ... }:
  {


programs.kitty = {
  enable = true;
  settings = {
    confirm_os_window_close = 0;
   }; 
  themeFile = "Catppuccin-Mocha";
};

wayland.windowManager.hyprland = {
  enable = true;
  systemd.enable = true;

  settings = {
    # Mod keys
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$filemanager" = "nautilus";

    exec-once = [
      "waybar"
      "swaync"

    ];

    monitor = [
      "HDMI-A-1,1920x1080@120.0,5760x102,1.0,transform,1,bitdepth,8" # To get monitor config on a new setup,
                       # use nwg-display, setup config and then find the
      "DP-2,1920x1080@143.98,1920x685,1.0,bitdepth,8"    # text at ~/.config/hypr/monitors.conf
      "DP-3,1920x1080@143.98,3840x685,1.0,bitdepth,8"
    ];

    # Keybindings
    bind = [
      "$mainMod, Return, exec, $terminal"        # Open terminal
      "$mainMod, C, killactive"                  # Close focused window
      "$mainMod, M, exit"                        # Exit Hyprland
      "$mainMod, Space, exec, rofi -show drun"   # Rofi launcher 
      "$mainMod, F, fullscreen, 1"               # Fullscreen Window
      "$mainMod, E, exec, $filemanager"          # Open file manager
      "SHIFT, PRINT, exec, bash -c 'hyprshot -m region --raw | satty --filename - --fullscreen'"        # Take a screenshot of a window interactively
      ", PRINT, exec, hyprshot -m region -o clipboard"     # Take a normal screenshot (no editing)
      "$mainMod, PRINT, exec, hyprshot -m window -o clipboard" # Take a screenshot of active window

      ### Vim Bindings for Window Switching ###
      "$mainMod, h, movefocus, l"
      "$mainMod, j, movefocus, d"
      "$mainMod, k, movefocus, u"
      "$mainMod, l, movefocus, r"
      ##########################################



    ];
    bindm = [
    "$mainMod, mouse:272, movewindow"
    # optionally:
    "$mainMod, mouse:273, resizewindow"
    ];
    bindle = [
      ", XF86AudioRaiseVolume, exec, vol --up"
      ", XF86AudioLowerVolume, exec, vol --down"
    ];

    bindl = [
      ", XF86AudioPlay, exec, playerctl play-pause" # the stupid key is called play , but it toggles
    ];
       };
    };
}
