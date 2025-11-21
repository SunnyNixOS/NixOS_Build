{ config, pkgs, lib, ... }:  
# This module is imported into home-manager for jaime-desktop
let

in
{   
  # Installs GNOME Extensions
  home.packages = with pkgs; [
     gnomeExtensions.transparent-top-bar-adjustable-transparency
     gnomeExtensions.hide-top-bar
     gnomeExtensions.dash2dock-lite
     gnomeExtensions.user-themes
     
     # Steam wrapper to launch steam in XWAYLAND mode every time (to help with mouse escaping windows on wayland)
    (pkgs.steam.overrideAttrs (old: {
      # Wrap the Steam binary to force XWayland
      postInstall = ''
        wrapProgram $out/bin/steam \
          --prefix STEAM_USE_XWAYLAND : 1
      '';
    }))
  ];
  
  # Allow unfree packages in home-manager (also in configuration.nix)
  nixpkgs.config = {
  allowUnfree = true;
  };
  
  # Sets system theme to WhiteSur-Dark-solid and to prefer dark mode for GTK applications.
  gtk = {
  enable = true;

  theme = {
    name = "WhiteSur-Dark-solid";   # exact theme folder name
    package = pkgs.whitesur-gtk-theme;
  };
  gtk3.extraConfig."gtk-application-prefer-dark-theme" = true;
  gtk4.extraConfig."gtk-application-prefer-dark-theme" = true;
  };
  
    ################
  # dconf explanation to help with adjusting settings:
  #
  # Open a program called dconfEditor and you can see that the options down below
  # are just dconf directories, stuff like the enabled extensions you can find in org/gnome/shell
  # and you can navigate all this stuff with a GUI. When in doubt, just click into the option and see
  # the formatting that the GUI app uses and copy it down here! Look how I did the favorite apps for
  # a good example of this. It's my dash2dock animated dock bar.
  #
  # An even better way to configure settings is to do "dconf watch /" and tweak something through the GUI menus.
  # It will show you exactly what files are changing so you can automate them down below.
  #
  ################
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
        # Use the terminal command "gnome-extensions list" to find these names. This is enabling installed extensions
          "dash2dock-lite@icedman.github.com"
          "hidetopbar@mathieu.bidon.ca"
          "transparent-top-bar@ftpix.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          
        ];
        
        # These are the icons that appear in your dock in the dash2dock extension
       favorite-apps = [
         "brave-browser.desktop"
         "obsidian.desktop"
         "bitwarden.desktop"
         "org.gnome.Console.desktop"
         "org.gnome.Nautilus.desktop"
         "vesktop.desktop"
        ]; 
      };
      
      # Adding minimize, maximize, close button to all windows
      "org/gnome/desktop/wm/preferences" = {
        "button-layout"="appmenu:minimize,maximize,close";
        };
        
       # Applying MacOS Whitesur Theme
      "org/gnome/shell/extensions/user-theme" = {
        name = "WhiteSur-Dark-solid";
        };
      
        # GNOME Interface Settings
       "org/gnome/desktop/interface" = {
           show-battery-percentage = true;
           clock-format = "12h";
           color-scheme = "prefer-dark";
           cursor-theme = "Adwaita";
           icon-theme = "Adwaita";
  };
      
      # GNOME Extensions Settings
      "org/gnome/shell/extensions/dash2dock-lite" = {
         "autohide-dash"=true;
         "open-app-animation"=true;
         "running-indicator-style"=1;
      
     };
   
   # Disable default GNOME screenshot keybindings
   "org/gnome/shell/keybindings" = {
     show-screenshot-ui = [];
     screenshot = [];
     };
   
   
  # Establish that a custom keybind exists
  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
  };

  # Define the custom keybind we just established (using it for flameshot screenshot tool)
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    name = "flameshot";
    command = ''script --command "QT_QPA_PLATFORM=wayland flameshot gui" /dev/null'';
    binding = "Print";
  };
};
};

}  
