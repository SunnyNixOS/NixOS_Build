{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jaime";
  home.homeDirectory = "/home/jaime";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName = "Sunny";
    userEmail = "sun+nxisoftgithub@coinblock25.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
     gnomeExtensions.transparent-top-bar-adjustable-transparency
     gnomeExtensions.hide-top-bar
     gnomeExtensions.dash2dock-lite
     gnomeExtensions.user-themes
     
     # Wrapped GnuCash
  (pkgs.stdenv.mkDerivation {
    name = "gnucash-wrapper";
    buildInputs = [ pkgs.makeWrapper pkgs.gnucash ];

    unpackPhase = "true"; # nothing to unpack

    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.gnucash}/bin/gnucash $out/bin/gnucash \
        --set WEBKIT_DISABLE_COMPOSITING_MODE 1
    '';
  })
  ];
  
  # This part installs the GTK Theme WhiteSur-Dark-solid and applies it to all gtk3 and gtk4 programs. If gtk4 apps do not work with
  # gtk theme, try editing "dconf.settings."org/gnome/desktop/interface".gtk-theme = "WhiteSur-Dark-solid";"

  
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
        # Use the terminal command "gnome-extensions list" to find these names
          "dash2dock-lite@icedman.github.com"
          "hidetopbar@mathieu.bidon.ca"
          "transparent-top-bar@ftpix.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          
        ];
        
        # These are the icons that appear in your dock in the dash2dock extension
       favorite-apps = [
         "vivaldi-stable.desktop"
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
  };
      
      # GNOME Extensions Settings
      "org/gnome/shell/extensions/dash2dock-lite" = {
         "autohide-dash"=true;
         "open-app-animation"=true;
         "running-indicator-style"=1;
     };
    };

  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jaime/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
}
